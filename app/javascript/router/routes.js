import _map from 'lodash/map';
import _extend from 'lodash/extend';

import SignUp from 'pages/sign_up/new.vue';
import SignIn from 'pages/sign_in/new.vue';
import HomeShow from 'pages/home/show.vue';

let routes = [
  {
    path: '/home',
    name: 'home',
    component: HomeShow,
  },
  {
    path: '',
    name: 'sign_in',
    component: SignIn,
  },
  {
    path: '/sign_up',
    name: 'sign_up',
    component: SignUp,
  },
];

routes = _map(routes, (route) => {
  return _extend({}, route, { props: true });
});
export default routes;

