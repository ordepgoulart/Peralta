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

      async handleAuth(dados){
        if(dados !== undefined){
          if(dados.mode === "login"){
            console.log(dados.senha, dados.email)
            await api.post("/guest/login", { senha: dados.senha, username : dados.email })
                .then((res) => {
                if(res.status === 200){
                  localStorage.setItem("Authorization", res.data.token);
                  this.$toast.success("Usuário logado com sucesso!");
                  if(res.data.nivel == 1)
                    this.$router.push("/admin");
                  else
                    this.$router.push("/basic");
                }
                else
                {
                  this.$toast.error("Houve um erro ao realizar o seu login");
                }
            })
            .catch((err) => {
              this.$toast.error("Houve um erro ao realizar o seu login");
            })
          }
          else 
          {
              api.post(`/guest/cadastrar/${dados.email}/${dados.senha}/${dados.cpf}`)
                  .then((res) => {
                    if(res.status === 200){
                      this.$toast.success("Usuário cadastrado com sucesso!");
                      this.authMode = "login";
                    }
                    else
                    {
                      this.$toast.error("Não foi possível realizar cadastrar!");
                    }
                  })
                  .catch((err) => {
                    console.log(err);
                    this.$toast.error(err.body.data);
                  });
          }
          //
        }
        
      }
    },
    mounted() {
      console.log('toast:', this.$toast)
    }
  }
</script>

<template>
  <div class="center">
    <StripSlide height="50px" />
    <div class="overlay">

      <div class="logo">
        <svg class="texto-curvado" viewBox="0 0 700 260" xmlns="http://www.w3.org/2000/svg">
          <defs>
            <path
                id="curva"
                d="M 120,210 A 230,230 0 0,1 580,210"
                fill="none"
            />
          </defs>

          <text
              class="texto-logo"
              fill="currentColor"
              font-size="72"
              font-weight="900"
              letter-spacing="12"
              font-family="Arial, sans-serif"
          >
            <textPath href="#curva" startOffset="50%" text-anchor="middle">
              PERALTA 99
            </textPath>
          </text>
        </svg>

        <img src="../../public/logoPeralta.png" alt="Logo" />
      </div>
      <div class="box-form">
        <AuthModal
            :mode="authMode"
            @update:mode="authMode = $event"
            @confirm="handleAuth"
        />
      </div>

    </div>
  </div>
</template>

<style scoped>

    .box-form
    {
      width: 40%;
      display: flex;
      z-index: 100000;
    }

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

    .texto-curvado
    {
      color: #f4d000;
      animation: piscarTexto 5.2s infinite ease-in-out;
      will-change: filter;
    }

    @keyframes piscarTexto
    {
      0%, 8%, 18%, 22%, 58%, 62%, 82%, 100%
      {
        filter:
            drop-shadow(0 0 6px rgba(255, 215, 0, 0.85))
            drop-shadow(0 0 18px rgba(255, 215, 0, 0.55))
            drop-shadow(0 4px 10px rgba(0, 0, 0, 0.65));
      }

      20%, 60%
      {
        filter:
            drop-shadow(0 0 2px rgba(160, 120, 0, 0.35))
            drop-shadow(0 0 6px rgba(160, 120, 0, 0.18))
            drop-shadow(0 3px 6px rgba(0, 0, 0, 0.45));
      }
    }

    .texto-logo
    {
      fill: var(--accent) !important;
      text-shadow: var(--shadow_yellow);

    }

    .texto-curvado text
    {
      fill: var(--accent) !important;
      text-shadow: var(--shadow_yellow);

    }

    .texto-curvado textPath
    {
      fill: var(--accent) !important;
      text-shadow: var(--shadow_yellow);

    }

    :deep(.texto-logo)
    {
      fill: var(--accent) !important;
      text-shadow: var(--shadow_yellow);

    }

    .logo
    {
      position: relative;
      display: flex;
      align-items: center;
      justify-content: center;
      width: 60%;
      min-height: 700px;
    }

    .texto-curvado
    {
      position: absolute;
      top: 40px;
      left: 50%;
      transform: translateX(-50%);
      width: 80rem;
      height: auto;
      overflow: visible;
      z-index: 2;
      margin-top: 14rem;
    }

    img
    {
      margin-top: 10rem;
      width: 64rem;
      opacity: 0.75;
    }

    .texto-curvado text
    {
      color: var(--accent);
      fill: white;
      font-size: 2rem;
      font-weight: 800;
      letter-spacing: 6px;
      text-transform: uppercase;
      opacity: 0.85;
    }

</style>