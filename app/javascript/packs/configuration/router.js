import VueRouter from 'vue-router';
import routes from 'router/routes';

const router = new VueRouter({
  routes,
  mode: 'history',
});

export default router;
