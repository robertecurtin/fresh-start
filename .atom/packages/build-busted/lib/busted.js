'use babel';

import fs from 'fs';
import path from 'path';
import { EventEmitter } from 'events';
import luaparse from 'luaparse';


const gatherBustedTasks = (dotbusted)=>{
  const tasks = [];
  const ast = luaparse.parse(fs.readFileSync(dotbusted, 'utf8'));
  const Return = ast.body[ast.body.length - 1];
  if (Return.type === 'ReturnStatement') {
    if (Return.arguments.length === 1) {
      const Table = Return.arguments[0];
      if (Table.type === 'TableConstructorExpression') {
        const fields = Table.fields;
        for (const field of fields) {
          const name = field.key.name;
          if (name !== '_all' && name !== 'default') {
            tasks.push(name);
          }
        }
      } else { // Table.type == 'Identifier'
        atom.notifications.addWarning('Can parse your .busted file', {
          dismissable: true,
          detail: `.busted should return a table constructor expression rather than ${Table.type.toLowerCase()}.`
        });
      }
    }
  }
  return tasks;
};

const watchFile = (provider, file)=>{
  provider.fileWatchers = provider.fileWatchers || [];
  provider.fileWatchers.push(fs.watch(file, () => provider.emit('refresh')));
};

const removeFileWatchers = (provider) => {
  (provider.fileWatchers || []).forEach(fw => fw.close());
  provider.fileWatchers = [];
};


export const config = {
  executable: {
    title: 'Busted executable path',
    description: 'Absolute path to `busted`. eg. `/usr/local/bin/busted`',
    type: 'string',
    default: /^win/.test(process.platform) ? 'busted.bat' : 'busted',
    order: 1
  }
};

export function provideBuilder() {
  return class MakeBuildProvider extends EventEmitter {
    constructor(cwd) {
      super();
      this.cwd = cwd;
      this.configWatcher = atom.config.observe('build-cocos.executable', ()=>{
        this.emit('refresh');
      });
    }

    destructor() {
      this.configWatcher.dispose();
      removeFileWatchers(this);
    }

    getNiceName() {
      return 'Busted';
    }

    isEligible() {
      removeFileWatchers(this);
      const dotbusted = path.join(this.cwd, '.busted');

      if (!fs.existsSync(dotbusted)) {
        return false;
      }
      watchFile(this, dotbusted);
      this.bustedTasks = gatherBustedTasks(dotbusted);

      return true;
    }

    settings() {
      const exec = atom.config.get('build-busted.executable');
      const errorMatch = ['(?<file>[^\\s]+\\.lua):(?<line>\\d+):'];
      const sh = false;
      let name = 'Busted';

      const tasks = [{name, exec, errorMatch, sh}];
      for (const task of this.bustedTasks) {
        name = `Busted: ${task}`;
        const args = [`--run=${task}`];
        tasks.push({name, exec, args, errorMatch, sh});
      }
      return tasks;
    }
  };
}
