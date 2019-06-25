<template>
  <div class="row">
    <div class="col-md-6 offset-md-3">
      <h2>Sign in</h2>
      <form class="simple_form form-horizontal">
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
            @click.prevent="handleSignIn"
          >
            Sign In
          </button>
        </div>
      </form>
    </div>
  </div>
</template>
<script>
import Alerts from '~components/shared/alerts';
import _get from 'lodash/get';
import signIn from '~mutations/signIn';
import { AUTH_TOKEN_KEY } from '~configuration/appConstants';
import { mapMutations } from 'vuex';

export default {
  name: 'SignIn',
  components: { Alerts },
  data() {
    return {
      errors: [],
      form: {},
    };
  },
  methods: {
    ...mapMutations(['signIn']),
    handleSignIn() {
      signIn({
        apollo: this.$apollo,
        ...this.form,
      }).then(response => _get(response, 'data.signIn', {}))
      .then(response => {
        if(response.success) {
          const user = response.user;
          this.signIn(user);
          localStorage.setItem(AUTH_TOKEN_KEY, user.authenticationToken);
          this.$router.push({ name: 'home' });
        } else {
          this.errors = this.errorMessages(response.data.signIn.errors);
        }
      }).catch(error => {
        this.errors = [error];
      });
    },
  },
};
</script>
