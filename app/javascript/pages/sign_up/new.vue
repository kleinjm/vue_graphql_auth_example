<template>
  <div class="row">
    <Alerts :alerts="errors" />
    <div class="col-md-6 offset-md-3">
      <h2>Sign up</h2>
      <form class="simple_form form-horizontal">
        <div class="form-group email optional user_email">
          <label class="control-label email optional">
            First Name
          </label>
          <input
            v-model="form.firstName"
            class="form-control string email optional"
            autofocus="autofocus"
          >
        </div>
        <div class="form-group email optional user_email">
          <label class="control-label email optional">
            Last Name
          </label>
          <input
            v-model="form.lastName"
            class="form-control string email optional"
            autofocus="autofocus"
          >
        </div>
        <div class="form-group email optional user_email">
          <label class="control-label email optional">
            Email
          </label>
          <input
            v-model="form.email"
            class="form-control string email optional"
            autofocus="autofocus"
          >
        </div>
        <div class="form-group password optional user_password">
          <label class="control-label password optional">
            Password
          </label>
          <input
            v-model="form.password"
            type="password"
            class="form-control password optional"
          >
        </div>
        <div class="text-center">
          <button
            class="btn btn-default btn btn-primary"
            @click.prevent="handleSignUp"
          >
            Sign up
          </button>
        </div>
      </form>
    </div>
  </div>
</template>
<script>
import Alerts from '~components/shared/alerts';
import _get from 'lodash/get';
import signUp from '~mutations/registerUser';
import { AUTH_TOKEN_KEY } from '~configuration/appConstants';
import { mapMutations } from 'vuex';

export default {
  name: 'SignUp',
  components: { Alerts },
  data() {
    return {
      errors: [],
      form: {},
    };
  },
  methods: {
    ...mapMutations(['signIn']),
    handleSignUp() {
      signUp({
        apollo: this.$apollo,
        ...this.form,
      }).then(response => _get(response, 'data.registerUser', {}))
      .then(response => {
        if(response.success) {
          const user = response.user;
          this.signIn(user); // using the Vuex store
          localStorage.setItem(AUTH_TOKEN_KEY, user.authenticationToken);
          this.$router.push({ name: 'home' });
        } else {
          this.errors = this.errorMessages(response.data.registerUser.errors);
        }
      }).catch(error => {
        this.errors = [error];
      });
    },
  },
};
</script>
