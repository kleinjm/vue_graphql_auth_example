<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <div
        id="navbarSupportedContent"
        class="collapse navbar-collapse"
      >
        <ul
          v-if="signedIn"
          class="navbar-nav"
        >
          <li class="nav-item active">
            <span class="nav-link disabled">
              {{ userFullName }}
            </span>
          </li>
          <li class="nav-item">
            <a
              class="nav-link"
              href="#"
              @click.prevent="handleSignOut"
            >
              Sign out
            </a>
          </li>
          <li class="nav-item">
            <router-link
              :to="{ name: 'home' }"
              class="nav-link"
            >
              Content Page
            </router-link>
          </li>
        </ul>
        <ul
          v-else
          class="navbar-nav"
        >
          <li class="nav-item">
            <router-link
              :to="{ name: 'sign_in' }"
              class="nav-link"
            >
              Sign In
            </router-link>
          </li>
          <li class="nav-item">
            <router-link
              :to="{ name: 'sign_up' }"
              class="nav-link"
            >
              Sign up
            </router-link>
          </li>
          <li class="nav-item">
            <router-link
              :to="{ name: 'home' }"
              class="nav-link"
            >
              Content Page
            </router-link>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
import _get from 'lodash/get';
import signOutMutation from '~mutations/signOut';
import { AUTH_TOKEN_KEY } from '~configuration/appConstants';
import { mapActions } from 'vuex';

export default {
  name: 'Navbar',
  methods: {
    ...mapActions(['signOut']),
    handleSignOut() {
      return signOutMutation({ apollo: this.$apollo })
        .then(response => _get(response, 'data.signOut.success', false))
        .then(success => {
          if(success) {
            this.signOut();
            localStorage.setItem(AUTH_TOKEN_KEY, '');
            return this.$apollo.provider.clients.defaultClient.resetStore();
          }
        }).then(() => {
          this.$router.push({ name: 'sign_in' });
        });
    },
  },
};
</script>
