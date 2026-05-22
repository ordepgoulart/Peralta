<script >
  import api from "../service/api.js";
  import AuthModal from "../components/forms/FormUsuario.vue";
  export default {
    name: "LoginView",
    components: {AuthModal},
    data() {
      return { authMode: "login" };
    },
    methods: {

      authMode(){

      },

      async handleAuth(){

      }
    }
  }
</script>

<template>
  <div class="center">
    <AuthModal
        :mode="authMode"
        @update:mode="authMode = $event"
        @confirm="handleAuth"
    />
  </div>
</template>

<style scoped>
    #center
    {
        padding: 60px;
    }
</style>