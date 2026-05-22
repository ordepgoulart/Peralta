<script >
  import api from "../service/api.js";
  import AuthModal from "../components/forms/FormUsuario.vue";
  import StripSlide from "../components/ui/StripSlide.vue";
  export default {
    name: "LoginView",
    components: {StripSlide, AuthModal},
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
    <StripSlide height="50px" />
    <div class="overlay">
      <div class="logo">

      </div>
      <AuthModal
          :mode="authMode"
          @update:mode="authMode = $event"
          @confirm="handleAuth"
      />
    </div>

  </div>
</template>

<style scoped>
    .center
    {
        padding-top: 30px;
    }
    .overlay
    {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.6);
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 1000;
      backdrop-filter: blur(4px);
    }
    .logo
    {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      width: 60%;
    }
</style>