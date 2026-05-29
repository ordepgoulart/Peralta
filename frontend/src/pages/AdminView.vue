<template>
    <div class="page-decor">
        <div class="page-side page-side--left">
            <StripSlideVertical height="100%" />
        </div>
        <div class="page-side page-side--right">
            <StripSlideVertical height="100%" />
        </div>
    </div>
    <section class="citizen-page">
        <div class="page-glow page-glow--left"></div>
        <div class="page-glow page-glow--right"></div>
        <header class="topbar">
            <div class="topbar__brand">
                <div class="brand-mark">
                    <img src="../../public/logoPeralta.png" alt="Logo" />
                </div>
                <div class="brand-copy">
                    <span class="brand-name">Peralta 99</span>
                    <span class="brand-subtitle">Painel do administrador</span>
                </div>
            </div>
            <nav class="topbar__nav">
                <button class="nav-link" type="button" @click="$router.push('/admin/tipos')">Gerenciar Tipos</button>
                <button class="nav-link" type="button" @click="orgaos">Gerenciar Órgãos</button>
            </nav>
            <button class="danger-action" type="button" @click="logout">Deslogar</button>
        </header>
        <section class="hero-panel">
            <span class="eyebrow">Painel do administrador</span>
            <h1>Todas as denúncias</h1>
            <p>
                Acompanhe o andamento das denúncias enviadas, filtre por status e clique nos cards para visualizar detalhes e respostas.
            </p>
        </section>
        <section class="citizen-summary-grid">
            <div class="summary-filters">
                <button
                    v-for="item in filtrosResumo()"
                    :key="item.valor"
                    class="summary-card"
                    :class="[ `summary-card--${item.variant}`, { 'summary-card--active': filtro === item.valor } ]"
                    type="button"
                    :aria-pressed="filtro === item.valor ? 'true' : 'false'"
                    @click="filtroResumo(item.valor)"
                >
                    <div class="summary-card__body">
                        <span class="summary-label">{{ item.label }}</span>
                        <strong class="summary-value">{{ item.total }}</strong>
                    </div>
                    <div class="summary-card__icon">
                        <component :is="item.icon" :size="24" :stroke-width="2" />
                    </div>
                    <span class="summary-card__glow"></span>
                </button>
            </div>
        </section>
        <section class="toolbar-shell">
            <div class="toolbar-panel">
                <div class="search-container">
                    <InputText
                        id="search-report"
                        :modelValue="busca"
                        placeholder="Buscar por título, tipo ou órgão"
                        @update:modelValue="atualizarBusca"
                    >
                        <template #icon>
                            <svg viewBox="0 0 24 24" aria-hidden="true" class="search-icon">
                                <path d="M10.5 18a7.5 7.5 0 1 1 5.303-2.197L21 21" />
                            </svg>
                        </template>
                    </InputText>
                </div>
            </div>
        </section>
        <section class="reports-shell">
            <div class="section-heading">
                <div>
                    <span class="section-kicker">Monitoramento</span>
                    <h2>Ocorrências cadastradas</h2>
                </div>
                <span class="section-caption">
                    Visualização central das denúncias registradas
                </span>
            </div>
            <div class="reports-grid">
                <DenunciaCardAdmin
                    v-if="listraFiltrada.length > 0"
                    v-for="denuncia in listraFiltrada"
                    :key="denuncia.id"
                    :denuncia="denuncia"
                    @select="abrirDetalhes"
                    @feedback="abrirModalFeedback"
                    @delete="confirmarDelecao"
                />
                <div v-else class="feedback-hint">
                    Nenhuma denúncia encontrada. Ajuste os filtros ou envie uma nova denúncia.
                </div>
            </div>
        </section>

        <DetalhesDenunciaModal :show="showDetalhes" :denuncia="denunciaSelecionada" :feedback="feedbackSelecionado" @close="fecharDetalhes" :admin-page="true" />
        <Form :show="showForm" title="Novo Feedback" :schema="formSchema" @close="showForm = false" @confirm="enviarFeedback" />
    </section>
</template>

<script>
import api from '../service/api.js';
import DetalhesDenunciaModal from "../components/DetalhesDenunciaModal.vue";
import Form from "../components/forms/Form.vue";
import InputText from "../components/forms/InputText.vue";
import StripSlideVertical from "../components/ui/StripSlideVertical.vue";
import Validator from "../utils/Validator.js";
import
{
    AlertTriangle,
    Clock3,
    ShieldCheck,
    LayoutGrid,
    ShieldAlert,
    InfoIcon
} from 'lucide-vue-next';
import DenunciaCardAdmin from "../components/DenunciaCardAdmin.vue";

export default
{
    name: "AdminView",
    components:
        {
            DenunciaCardAdmin,
            StripSlideVertical,
            DetalhesDenunciaModal,
            Form,
            InputText,
            AlertTriangle,
            Clock3,
            ShieldCheck,
            ShieldAlert,
            LayoutGrid,
            InfoIcon
        },
    data()
    {
        return {
            showDetalhes: false,
            showForm: false,
            denuncias: [],
            listraFiltrada: [],
            denunciaSelecionada: null,
            feedbackSelecionado: null,
            totais: 0,
            alta: 0,
            media: 0,
            baixa: 0,
            sem: 0,
            muito: 0,
            filtro: 0,
            busca: '',
        };
    },
    computed:
        {
            formSchema()
            {
                return [
                    {
                        fields:
                            [
                                {
                                    name: "texto",
                                    label: "Feedback",
                                    type: "textarea",
                                    placeholder: "Detalhe a resolução ou medidas tomadas.",
                                    validator: Validator.required,
                                    required: true
                                }
                            ]
                    }
                ];
            }
        },
    methods:
        {
            abrirModalFeedback(valor)
            {
                this.showForm = true;
                this.denunciaSelecionada = valor;
            },

            confirmarDelecao(valor)
            {
                api.delete(`/apis/admin/delete-report/${valor.id}`)
                    .then(
                        response =>
                        {
                            if (response.status === 200)
                            {
                                this.$toast.success('A denúncia "' + valor.titulo + '" foi deletada com sucesso!');
                                this.buscarDenuncias();
                            }
                        }
                    ).catch(error =>
                {
                    this.$toast.error("Ocorreu um erro ao deletar a denúncia.");
                });
            },

            filtroResumo(valor)
            {
                this.filtro = valor;
                this.aplicarFiltros();
            },

            atualizarBusca(valor)
            {
                this.busca = valor;
                this.aplicarFiltros();
            },

            aplicarFiltros()
            {
                let lista = [...this.denuncias];

                if (this.filtro !== 0)
                {
                    lista = lista.filter(d => d.urgencia === this.filtro);
                }

                if (this.busca?.trim())
                {
                    const termo = this.busca.toLowerCase();

                    lista = lista.filter(d =>
                        d?.titulo?.toLowerCase().includes(termo) ||
                        d?.tipo?.nome?.toLowerCase().includes(termo) ||
                        d?.orgao?.nome?.toLowerCase().includes(termo)
                    );
                }

                this.listraFiltrada = lista;
            },

            fecharDetalhes()
            {
                this.showDetalhes = false;
                this.denunciaSelecionada = null;
                this.feedbackSelecionado = null;
            },

            atualizarResumo()
            {
                this.totais = this.denuncias.length;
                this.muito = this.denuncias.filter(d => d.urgencia === 5).length;
                this.alta = this.denuncias.filter(d => d.urgencia === 4).length;
                this.media = this.denuncias.filter(d => d.urgencia === 3).length;
                this.baixa = this.denuncias.filter(d => d.urgencia === 2).length;
                this.sem = this.denuncias.filter(d => d.urgencia === 1).length;
            },

            filtrosResumo()
            {
                return [
                    {
                        valor: 5,
                        label: 'Crítica',
                        total: this.muito,
                        variant: 'danger',
                        icon: 'AlertTriangle'
                    },
                    {
                        valor: 4,
                        label: 'Alta Urgência',
                        total: this.alta,
                        variant: 'alert',
                        icon: 'ShieldAlert'
                    },
                    {
                        valor: 3,
                        label: 'Média Urgência',
                        total: this.media,
                        variant: 'warning',
                        icon: 'Clock3'
                    },
                    {
                        valor: 2,
                        label: 'Baixa urgência',
                        total: this.baixa,
                        variant: 'success',
                        icon: 'ShieldCheck'
                    },
                    {
                        valor: 1,
                        label: 'Sem urgência',
                        total: this.sem,
                        variant: 'neutral',
                        icon: 'InfoIcon'
                    },
                    {
                        valor: 0,
                        label: 'Total de denúncias',
                        total: this.totais,
                        variant: 'neutral',
                        icon: 'LayoutGrid'
                    }
                ];
            },

            async abrirDetalhes(denuncia)
            {
                this.denunciaSelecionada = denuncia;

                await api.get(`/apis/basic/get-feedback/${denuncia.id}`)
                    .then(response =>
                    {
                        if (response.status === 200)
                        {
                            this.feedbackSelecionado = response.data;
                        }
                        else
                        {
                            this.feedbackSelecionado = null;
                        }
                    })
                    .catch(() =>
                    {
                        this.feedbackSelecionado = null;
                    });

                this.showDetalhes = true;
            },

            orgaos()
            {
                this.$router.push("/admin/orgaos");
            },

            async buscarDenuncias()
            {
                await api.get(`/apis/admin/all-reports`)
                    .then(response =>
                    {
                        if (response.status === 200)
                        {
                            this.denuncias = response.data.map(d =>
                            {
                                if (d.data && d.data.includes(' '))
                                {
                                    d.data = d.data.replace(' ', 'T');
                                }
                                return d;
                            });
                            this.atualizarResumo();
                            this.aplicarFiltros();
                        }
                        else
                        {
                            this.$toast.error("Erro ao carregar denúncias.");
                        }
                    });
            },

            async enviarFeedback(formDados)
            {
                try
                {
                    const payload =
                        {
                            texto: formDados.texto,
                            denuncia: this.denunciaSelecionada
                        };

                    const response = await api.post("/apis/admin/add-feedback", payload);

                    if (response.status === 200 || response.status === 201)
                    {
                        this.$toast.success("Feedback registrado com sucesso!");
                        this.showForm = false;
                        await this.buscarDenuncias();
                    }
                }
                catch (error)
                {
                    this.$toast.error("Erro ao salvar o feedback.");
                    this.$toast.error(error.response.data);
                }
            },

            logout()
            {
                localStorage.removeItem("Authorization");
                localStorage.removeItem("usuario");
                this.$router.push("/login");
            }
        },
    async mounted()
    {
        try
        {
            const usuario = JSON.parse(localStorage.getItem("usuario") || "null");
            const token = localStorage.getItem("Authorization");

            if (!usuario || !usuario.id || !token)
            {
                throw new Error("Usuário ou token ausente");
            }
            else if(usuario.nivel != 1)
            {
                throw new Error('Não autorizado');
            }

            await this.buscarDenuncias();

            this.listraFiltrada = this.denuncias;
        }
        catch (error)
        {
            localStorage.removeItem("Authorization");
            localStorage.removeItem("usuario");
            this.$toast.error("Faça login para acessar o painel do administrador novamente.");
            this.$router.push("/login");
        }
    }
};
</script>

<style scoped>
.citizen-page
{
    --bg: #050507;
    --bg-2: #0a0a0f;
    --panel: rgba(14, 14, 18, 0.88);
    --panel-strong: rgba(18, 18, 24, 0.96);
    --panel-soft: rgba(255, 255, 255, 0.03);
    --border: rgba(255, 255, 255, 0.08);
    --text: #f5f5f7;
    --text-soft: #c8c8d1;
    --text-muted: #8e8e99;
    --yellow: #f3df13;
    --red: #ff4d57;
    min-height: 100vh;
    padding: 28px;
    color: var(--text);
    position: relative;
    overflow: hidden;
    display: grid;
    z-index: 1;
    gap: 28px;
}

.page-glow
{
    position: absolute;
    width: 360px;
    height: 360px;
    border-radius: 999px;
    filter: blur(90px);
    opacity: 0.22;
    pointer-events: none;
}

.page-glow--left
{
    top: -90px;
    left: -120px;
    background: rgba(141, 120, 255, 0.18);
}

.page-glow--right
{
    top: 40px;
    right: -100px;
    background: rgba(243, 223, 19, 0.08);
}

.topbar
{
    position: relative;
    z-index: 1;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 24px;
    padding: 16px 22px;
    background: linear-gradient(180deg, rgba(14, 14, 18, 0.88), rgba(10, 10, 14, 0.74));
    border: 1px solid var(--border);
    border-radius: 24px;
    backdrop-filter: blur(14px);
}

.topbar__brand
{
    display: flex;
    align-items: center;
    gap: 14px;
}

.brand-mark img
{
    width: 72px;
    height: 56px;
    opacity: 0.8;
}

.brand-copy
{
    display: grid;
    gap: 2px;
}

.brand-name
{
    font-size: 1.1rem;
    font-weight: 800;
    letter-spacing: 0.03em;
}

.brand-subtitle
{
    color: var(--text-muted);
    font-size: 0.82rem;
}

.topbar__nav
{
    display: flex;
    gap: 10px;
}

.nav-link
{
    min-height: 42px;
    padding: 0 16px;
    border: 1px solid transparent;
    border-radius: 999px;
    background: transparent;
    color: var(--text-soft);
    font-size: 0.92rem;
    font-weight: 700;
    cursor: pointer;
    transition: 180ms ease;
}

.nav-link:hover
{
    background: rgba(255, 255, 255, 0.04);
    color: var(--yellow);
    border-color: rgba(243, 223, 19, 0.18);
}

.danger-action
{
    min-height: 42px;
    padding: 0 16px;
    border-radius: 999px;
    border: 1px solid rgba(255, 77, 87, 0.34);
    background: rgba(255, 77, 87, 0.06);
    color: var(--red);
    font-size: 0.92rem;
    font-weight: 800;
    cursor: pointer;
    transition: 180ms ease;
}

.danger-action:hover
{
    background: rgba(255, 77, 87, 0.8);
    color: #0a0a0a;
}

.hero-panel
{
    position: relative;
    z-index: 1;
    display: grid;
    gap: 14px;
}

.eyebrow,
.section-kicker
{
    display: inline-flex;
    align-items: center;
    gap: 8px;
    color: var(--yellow);
    font-size: 0.8rem;
    font-weight: 800;
    letter-spacing: 0.12em;
    text-transform: uppercase;
}

.hero-panel h1
{
    margin: 0;
    font-size: clamp(3rem, 6vw, 5rem);
    line-height: 0.94;
    letter-spacing: -0.05em;
    font-weight: 900;
}

.hero-panel p
{
    margin: 0;
    max-width: 64ch;
    color: var(--text-soft);
    font-size: 1rem;
    line-height: 1.75;
}

.toolbar-shell
{
    position: relative;
    z-index: 1;
}

.toolbar-panel
{
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 16px;
    padding: 18px;
    background: linear-gradient(180deg, rgba(15, 15, 20, 0.92), rgba(10, 10, 14, 0.94));
    border: 1px solid rgba(255, 255, 255, 0.07);
    border-radius: 26px;
}

.search-container
{
    flex: 1;
}

.search-icon
{
    width: 18px;
    height: 18px;
    stroke: var(--yellow);
    stroke-width: 2;
    fill: none;
}

.reports-shell
{
    display: grid;
    gap: 18px;
    padding: 22px;
    background: linear-gradient(180deg, rgba(14, 14, 18, 0.90), rgba(10, 10, 14, 0.96));
    border: 1px solid rgba(255, 255, 255, 0.07);
    border-radius: 28px;
}

.section-heading
{
    display: flex;
    align-items: flex-end;
    justify-content: space-between;
    gap: 16px;
}

.section-heading h2
{
    margin: 6px 0 0;
    font-size: clamp(1.8rem, 3vw, 2.5rem);
    line-height: 1;
    letter-spacing: -0.04em;
}

.section-caption
{
    color: var(--text-muted);
    font-size: 0.9rem;
}

.reports-grid
{
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 18px;
    min-height: 220px;
    padding: 20px 10px;
    align-items: start;
}

.feedback-hint
{
    min-height: 220px;
    display: grid;
    place-items: center;
    padding: 24px;
    border-radius: 22px;
    border: 1px dashed rgba(141, 120, 255, 0.26);
    background: linear-gradient(180deg, rgba(141, 120, 255, 0.05), rgba(141, 120, 255, 0.03));
    color: #ddd7ff;
    text-align: center;
    font-weight: 700;
    grid-column: 1 / -1;
}

.page-decor
{
    position: fixed;
    inset: 0;
    pointer-events: none;
    z-index: 0;
    overflow: hidden;
}

.page-side
{
    position: absolute;
    top: 0;
    height: 100vh;
    width: 84px;
    opacity: 0.18;
    filter: blur(6px);
}

.page-side--left
{
    left: -18px;
}

.page-side--right
{
    right: -18px;
    transform: scaleX(-1);
}

.summary-filters
{
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 18px;
}

.summary-card
{
    position: relative;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 16px;
    width: 100%;
    min-height: 116px;
    padding: 18px 20px;
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 22px;
    background: linear-gradient(180deg, rgba(18, 18, 24, 0.96), rgba(12, 12, 16, 0.98));
    color: #f4f4f7;
    cursor: pointer;
    overflow: hidden;
    transition: transform 180ms ease, border-color 180ms ease;
}

.summary-card:hover
{
    transform: translateY(-3px);
    border-color: rgba(255, 255, 255, 0.14);
}

.summary-card--active
{
    border-color: rgba(243, 223, 19, 0.30);
    background: linear-gradient(180deg, rgba(24, 24, 30, 0.98), rgba(14, 14, 18, 1));
}

.summary-card__body
{
    display: grid;
    gap: 10px;
}

.summary-label
{
    font-size: 0.76rem;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    color: #8c8c97;
    font-weight: 700;
}

.summary-value
{
    font-size: clamp(1.9rem, 2.8vw, 2.4rem);
    line-height: 0.95;
    font-weight: 900;
    letter-spacing: -0.05em;
}

.summary-card__icon
{
    width: 58px;
    height: 58px;
    border-radius: 18px;
    display: grid;
    place-items: center;
    background: rgba(255, 255, 255, 0.04);
    border: 1px solid rgba(255, 255, 255, 0.06);
}

.summary-card__icon svg
{
    width: 24px;
    height: 24px;
    stroke: currentColor;
    stroke-width: 1.9;
    fill: none;
}

.summary-card__glow
{
    position: absolute;
    inset: auto -40px -40px auto;
    width: 110px;
    height: 110px;
    border-radius: 999px;
    filter: blur(36px);
    opacity: 0.16;
}

.summary-card--danger .summary-value,
.summary-card--danger .summary-card__icon
{
    color: #ff6671;
}

.summary-card--danger .summary-card__glow
{
    background: rgba(255, 102, 113, 0.32);
}

.summary-card--warning .summary-value,
.summary-card--warning .summary-card__icon
{
    color: #f3df13;
}

.summary-card--warning .summary-card__glow
{
    background: rgba(243, 223, 19, 0.24);
}

.summary-card--success .summary-value,
.summary-card--success .summary-card__icon
{
    color: #d9d6c2;
}

.summary-card--success .summary-card__glow
{
    background: rgba(217, 214, 194, 0.18);
}

.summary-card--neutral .summary-value,
.summary-card--neutral .summary-card__icon
{
    color: #a897ff;
}

.summary-card--neutral .summary-card__glow
{
    background: rgba(168, 151, 255, 0.26);
}

.summary-card--alert .summary-value,
.summary-card--alert .summary-card__icon
{
    color: #FF6D00;
}

.summary-card--alert .summary-card__glow
{
    background: rgba(255, 109, 0, 0.26);
}

@media (max-width: 1200px)
{
    .reports-grid
    {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 1100px)
{
    .topbar
    {
        flex-direction: column;
        align-items: stretch;
    }

    .topbar__nav
    {
        justify-content: flex-start;
        flex-wrap: wrap;
    }

    .toolbar-panel
    {
        flex-direction: column;
        align-items: stretch;
    }

    .search-container
    {
        max-width: 100%;
    }
}

@media (max-width: 720px)
{
    .citizen-page
    {
        padding: 18px;
    }

    .reports-grid
    {
        grid-template-columns: 1fr;
    }
}
</style>