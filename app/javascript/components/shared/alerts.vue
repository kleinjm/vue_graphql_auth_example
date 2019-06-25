<template>
  <div
    v-if="showAlerts"
    class="alert alert-danger"
    role="alert"
  >
    <ul class="list-unstyled">
      <li
        v-for="(alert, index) in alerts"
        :key="index"
      >
        {{ alert }}
      </li>
    </ul>
  </div>
</template>
<script>
export default {
  name: 'Alerts',
  props: {
    alerts: {
      type: Array,
      default: () => [],
    },
  },
  computed: {
    showAlerts() {
      return this.alerts.length;
    },
  },
};
</script>
