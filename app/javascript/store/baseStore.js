import * as Cookies from 'js-cookie';
import createPersistedState from 'vuex-persistedstate';
import usersStore from './usersStore';
import { Store } from 'vuex';

export default function createStore() {
  return new Store({
    plugins: [
      createPersistedState({
        getState: (key) => {
          return Cookies.getJSON(key);
        },
        setState: (key, state) => {
          Cookies.set(key, state, { expires: 3 }); // 3 days
        },
      }),
    ],
    modules: {
      usersStore,
    },
  });
}
