const state = {
  user: {},
};

const getters = {
  user: state => {
    return state.user;
  },
};

const mutations = {
  signIn(state, user) {
    state.user = user;
  },
  clearUser(state) {
    state.user = {};
  },
};

const actions = {
  signOut(context) {
    context.commit('clearUser');
  },
  signIn(context, user) {
    context.commit('signIn', user);
  },
};

export default { state, getters, mutations, actions };
