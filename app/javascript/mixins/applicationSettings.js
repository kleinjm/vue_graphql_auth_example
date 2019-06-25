import _isEmpty from 'lodash/isEmpty';
import { AUTH_TOKEN_KEY } from '~configuration/appConstants';
import { mapGetters } from 'vuex';

function authTokenExists() {
  const token = localStorage.getItem(AUTH_TOKEN_KEY);

  return token !== '' && token !== undefined && token !== null;
}

export default {
  computed: {
    ...mapGetters(['user']),
    signedIn() {
      return !_isEmpty(this.user) && authTokenExists();
    },
    userFullName() {
      if(!this.signedIn) return '';
      return `${this.user.firstName} ${this.user.lastName}`;
    },
  },
};
