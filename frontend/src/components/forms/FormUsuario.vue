<template>
      <div class="modal-container">

            <main class="modal-body">
                <div class="auth-form">
                    <div class="form-top">
                        <h4>{{ tituloFormulario }}</h4>
                        <p>{{ descricaoFormulario }}</p>
                    </div>

                    <div class="form-grid">
                        <div v-if="!isLogin" class="form-group">
                            <label for="nome">CPF</label>
                            <input
                                id="nome"
                                v-model="form.cpf"
                                type="text"
                                placeholder="Digite o CPF"
                            />
                        </div>

                        <div class="form-group">
                            <label for="email">E-mail</label>
                            <input
                                id="email"
                                v-model="form.email"
                                type="email"
                                placeholder="Digite seu e-mail"
                            />
                        </div>

                        <div class="form-group">
                            <label for="senha">Senha</label>
                            <input
                                id="senha"
                                v-model="form.senha"
                                type="password"
                                placeholder="Digite sua senha"
                                @keyup.enter="confirmarAcao"
                            />
                        </div>
                    </div>

                    <div class="form-switch">
                        <span>{{ textoAlternancia }}</span>

                        <button
                            type="button"
                            class="switch-btn"
                            @click="alternarModo"
                        >
                            {{ botaoAlternancia }}
                        </button>
                    </div>
                </div>
            </main>

            <footer class="modal-footer">
                <Button @click="limparFormulario" class="btn-cancel">Limpar</Button>
                <Button @click="confirmarAcao" class="btn-confirm">
                    {{ textoBotaoConfirmar }}
                </Button>
            </footer>
        </div>
</template>

<script>
import Button from "../ui/Button.vue";
import StripSlide from "../ui/StripSlide.vue";

export default {
    name: "AuthModal",
    components: {
        Button,
        StripSlide
    },
    props: {
        mode: {
            type: String,
            default: "login"
        },
        title: {
            type: String,
            default: ""
        }
    },
    emits: ["confirm", "update:mode"],
    data() {
        return {
            currentMode: this.mode,
            form: {
                cpf: "",
                email: "",
                senha: "",
            }
        };
    },
    methods: {
        alternarModo() {
            const novoModo = this.currentMode === "login" ? "register" : "login";
            this.currentMode = novoModo;
            this.$emit("update:mode", novoModo);
        },
        limparFormulario() {
            this.form.cpf = "";
            this.form.email = "";
            this.form.senha = "";
        },
        confirmarAcao() {
            this.$emit("confirm", {
                mode: this.currentMode,
                cpf: this.form.cpf,
                email: this.form.email,
                senha: this.form.senha,
            });
        }
    },
    computed: {
        isLogin() {
            return this.currentMode === "login";
        },
        modalTitle() {
            if (this.title) return this.title;
            return this.isLogin ? "Login de Usuário" : "Cadastro de Usuário";
        },
        tituloFormulario() {
            return this.isLogin ? "Entrar na conta" : "Cadastrar usuário";
        },
        descricaoFormulario() {
            return this.isLogin
                ? "Informe seus dados para acessar o sistema."
                : "Preencha os campos abaixo para criar uma nova conta.";
        },
        textoAlternancia() {
            return this.isLogin ? "Não possui conta?" : "Já possui conta?";
        },
        botaoAlternancia() {
            return this.isLogin ? "Cadastrar" : "Fazer login";
        },
        textoBotaoConfirmar() {
            return this.isLogin ? "Entrar" : "Cadastrar";
        }
    },
    watch: {
        mode(novoValor) {
            this.currentMode = novoValor;
            this.limparFormulario();
        },
        show(novoValor) {
            if (!novoValor) {
                this.limparFormulario();
            }
        }
    },
    beforeMount() {
    },
    created() {
    },
    mounted() {
    },
    unmounted() {
    }
};
</script>

<style scoped>


.modal-container
{
    padding-top: 20px;
    background: var(--bg);
    width: 100%;
    max-width: 500px;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 8px 32px rgba(255,255,255,0.4);
    display: flex;
    flex-direction: column;
}

.modal-header h3
{
    margin: 0;
    text-transform: uppercase;
    letter-spacing: 1px;
    font-size: 1.1em;
}

.modal-body
{
    padding: 20px;
}

.modal-footer
{
    padding: 20px;
    display: flex;
    gap: 15px;
    justify-content: flex-end;
    background: rgba(255, 255, 255, 0.02);
    border-top: 1px solid var(--border);
}

.btn-cancel
{
    background: #3C0061 !important;
    box-shadow: 6px 8px rgba(157,0,255, 0.1);
    font-size: 0.85em;
    font-weight: bold;
    text-shadow: rgba(149, 165, 166, 0.1) 1px 1px 1px;
    color: white !important;
    padding: 10px 20px !important;
}

.btn-confirm
{
    padding: 10px 20px !important;
    background: #EBBE4D !important;
    box-shadow: 6px 8px rgba(186,142,35, 0.1);
    font-size: 0.85em;
    font-weight: bold;
    text-shadow: rgba(255, 255, 255, 0.1) 1px 1px 1px;
    color: black !important;
}

.auth-form
{
    display: flex;
    flex-direction: column;
    gap: 20px;
    color: var(--text);
}

.form-top
{
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.form-top h4
{
    margin: 0;
    text-transform: uppercase;
    letter-spacing: 1px;
    font-size: 1rem;
    color: rgba(186, 142, 35 , 1);
    font-weight: bold;
}

.form-top p
{
    margin: 0;
    font-size: 0.92rem;
    line-height: 1.5;
    color: var(--text-muted, rgba(255, 255, 255, 0.65));
}

.form-grid
{
    display: grid;
    gap: 16px;
}

.form-group
{
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.form-group label
{
    font-size: 0.82rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    color: var(--text);
}

.form-group input
{
    width: 90%;
    margin-left: 0.4rem;
    padding: 12px 14px;
    border-radius: 10px;
    border: 1px solid rgba(186, 142, 35 , 0.1);
    background: rgba(186, 142, 35 , 0.03);
    box-shadow: 0 6px 12px rgba(255, 255, 197, 0.3);
    color: var(--text);
    outline: none;
    transition: border-color 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
}

.form-group input::placeholder
{
    color: rgba(255, 255, 255, 0.35);
}

.form-group input:focus
{
    border-color: var(--primary, #42b883);
    box-shadow: 0 0 0 3px rgba(66, 184, 131, 0.15);
    background: rgba(255, 255, 255, 0.05);
}

.form-switch
{
    padding-top: 16px;
    border-top: 1px solid var(--border);
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 12px;
    font-size: 0.9rem;
    color: var(--text-muted, rgba(255, 255, 255, 0.65));
}

.switch-btn
{
    background: none;
    border: none;
    color: var(--primary, #42b883);
    font-weight: 700;
    cursor: pointer;
    transition: opacity 0.2s ease;
}

.switch-btn:hover
{
    opacity: 0.8;
}
</style>