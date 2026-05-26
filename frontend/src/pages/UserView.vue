<script>
  import DenunciaCard from '../components/DenunciaCard.vue';
  import api from '../service/api.js';
  export default {
    name: "UserView",
    components : {
      DenunciaCard,
    },
    data() {
      return {
        recarregar: null,
        listaOrgaos: [],
        listaTipos : [],
        denuncias: [],
        feedback: null,
        totais : 0,
        alta : 0,
        media : 0,
        baixa : 0,
        filtro : 'T',
        busca : '',
      };
    },
    methods : {
      async buscarOrgaos() {
        await api.get("/apis/basic/get-institutions")
        .then(response => {
          if(response.status === 200) {
            this.listaOrgaos = response.data;
            this.$toast.success("Órgãos carregados com sucesso.");
          }
          else {
            this.$toast.error("Erro ao carregar órgãos. Tente novamente mais tarde.");
          }
        })
      },
      async buscarTipos() {
        await api.get("/apis/basic/get-type_problems")
        .then(response => {
          if(response.status === 200) {
            this.listaTipos = response.data;
            this.$toast.success("Tipos de problemas carregados com sucesso.");
          }
          else {
            this.$toast.error("Erro ao carregar tipos de problemas. Tente novamente mais tarde.");
          }
        })
      },
      filtro(valor){
        this.filtro = valor;
      },
      busca(valor){
        this.busca = valor;
      },
      async abrirFeedback(denuncia) {
        await api.get(`/apis/basic/get-feedback/${denuncia.id}`)
         .then(response => {
          if(response.status === 200) {
            this.feedback = response.data;
            this.$toast.success("Feedback carregado com sucesso.");
          }
          else {
            this.feedback = null;
            this.$toast.error("Erro ao carregar feedback. Tente novamente mais tarde.");
          }
        })
         .catch(() => {
          this.feedback = null;
          this.$toast.error("Erro ao carregar feedback. Tente novamente mais tarde.");
        });
      },
      async buscarMinhasDenuncias(id){
        await api.get(`/apis/basic/view-my-reports/${id}`)
        .then(response => {
          if(response.status === 200) {
            this.denuncias = response.data;
            this.$toast.success("Denúncias carregadas com sucesso.");
            this.totais = this.denuncias.length;
            this.pendentes = this.denuncias.filter(d => d.get)
          }
          else {
            this.$toast.error("Erro ao carregar denúncias. Tente novamente mais tarde.");
          }
        })
      }
    },
    async created(){
      const usuario = localStorage.getItem("Authorization");
      if(!usuario){
        this.$toast.error("Faça login para acessar o painel do cidadão.");
        this.$router.push("/login");
      }
      else 
      {
        await this.buscarOrgaos();
        await this.buscarTipos();
        await this.buscarMinhasDenuncias(usuario.id);
        this.listraFiltrada = this.denuncias;
        this.recarregar = setInterval(async () =>{ 
          await this.buscarOrgaos();
          await this.buscarTipos();
          await this.buscarMinhasDenuncias(usuario.id);
        }, 2 * 60 * 1000)
      }
    }
  }

</script>

<template>
  <section class="citizen-page">
    <header class="citizen-header">
      <div class="header-copy">
        <span class="eyebrow">Painel do cidadão</span>
        <h1>Minhas denúncias</h1>
        <p>
          Acompanhe o andamento das denúncias enviadas, filtre por status e clique nos cards respondidos para visualizar o feedback do órgão responsável.
        </p>
      </div>
    </header>

    <section class="citizen-summary-grid">
      

      <button class="summary-card" value="A" v-on:click="filtro(this.value)">
        <span class="summary-label">Alta Urgência</span>
        <strong class="summary-value warning">{{ alta }}</strong>
      </button>

      <button class="summary-card" value="M" v-on:click="">
        <span class="summary-label">Média Urgência</span>
        <strong class="summary-value success">{{ media }}</strong>
      </button>

      <button class="summary-card summary-card--highlight" value="B" v-on:click="filtro(this.value)">
        <span class="summary-label">Baixa Urgência</span>
        <strong class="summary-value">{{ baixa }}</strong>
      </button>

      <button class="summary-card" value="T" v-on:click="filtro(this.value)">
        <span class="summary-label">Total de denúncias</span>
        <strong class="summary-value">{{ totais }}</strong>
      </button>
    </section>

    <section class="toolbar-panel">
      <div class="toolbar-left">
        <label class="search-box" for="search-report">
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <path d="M10.5 18a7.5 7.5 0 1 1 5.303-2.197L21 21" />
          </svg>
          <input
            id="search-report"
            type="text"
            placeholder="Buscar por título, tipo ou órgão"
          />
        </label>
      </div>

      <div class="toolbar-right">
        <button class="primary-action" type="button">Nova denúncia</button>
        <button class="primary-action" type="button">Listar Órgãos</button>
        <button class="primary-action" type="button">Listar Tipos</button>
      </div>
    </section>

    <section class="reports-section">
      <div class="section-heading">
        <div>
          <span class="section-kicker">Grid de denúncias</span>
          <h2>Ocorrências cadastradas</h2>
        </div>

        <span class="section-caption">Cards clicáveis exibem o feedback quando disponível</span>
      </div>

      <div class="reports-grid">
        <DenunciaCard
          v-if="denuncias.length > 0" 
          v-for="denuncia in listraFiltrada"
          :key="denuncia.id"
          :denuncia="denuncia"
          imageBaseUrl="http://localhost:8080/uploads/"
          @select="abrirFeedback"
        />
        <div v-else class="feedback-hint">
          Nenhuma denúncia encontrada. Envie uma nova denúncia para começar a acompanhar o feedback dos órgãos responsáveis.
        </div>
      </div>
    </section>

    <FeedbackModal
      :feedback="feedback"
      @close="fecharFeedback"
    />
    
  </section>
</template>

<style scoped>
.citizen-page {
  --page-bg: linear-gradient(180deg, #0d1016 0%, #121722 100%);
  --surface: rgba(18, 24, 35, 0.88);
  --surface-strong: rgba(24, 31, 46, 0.98);
  --surface-soft: rgba(255, 255, 255, 0.04);
  --border: rgba(255, 255, 255, 0.08);
  --border-strong: rgba(255, 255, 255, 0.14);
  --text: #f4f7fb;
  --text-muted: #a2aec2;
  --text-faint: #7d8798;
  --accent: #f4d000;
  --accent-soft: rgba(244, 208, 0, 0.14);
  --accent-strong: rgba(244, 208, 0, 0.24);
  --success: #53d18b;
  --success-soft: rgba(83, 209, 139, 0.14);
  --warning: #ffb84d;
  --warning-soft: rgba(255, 184, 77, 0.16);
  --danger: #ff7d7d;
  --danger-soft: rgba(255, 125, 125, 0.16);
  --shadow: 0 18px 42px rgba(0, 0, 0, 0.28);
  --radius-xl: 24px;
  --radius-lg: 18px;
  --radius-md: 14px;
  --radius-pill: 999px;
  min-height: 100vh;
  padding: 32px;
  background: var(--page-bg);
  color: var(--text);
  display: grid;
  gap: 28px;
}

.citizen-header,
.citizen-summary-grid,
.toolbar-panel,
.reports-section,
.feedback-preview-panel {
  width: 100%;
}

.citizen-header {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  gap: 24px;
  padding: 30px;
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow);
}

.header-copy {
  max-width: 760px;
  display: grid;
  gap: 10px;
}

.eyebrow,
.section-kicker,
.feedback-label {
  font-size: 0.76rem;
  text-transform: uppercase;
  letter-spacing: 0.14em;
  color: var(--accent);
}

.header-copy h1,
.section-heading h2,
.feedback-preview-card h3 {
  margin: 0;
  line-height: 1.1;
}

.header-copy h1 {
  font-size: clamp(2rem, 3vw, 2.8rem);
}

.header-copy p {
  margin: 0;
  max-width: 62ch;
  font-size: 0.98rem;
  line-height: 1.7;
  color: var(--text-muted);
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}

.primary-action {
  min-height: 46px;
  padding: 0 20px;
  border: 1px solid transparent;
  border-radius: var(--radius-pill);
  background: var(--accent);
  color: #11151f;
  font-size: 0.95rem;
  font-weight: 700;
  cursor: pointer;
  transition: transform 180ms ease, box-shadow 180ms ease, opacity 180ms ease;
  box-shadow: 0 12px 28px rgba(244, 208, 0, 0.22);
}

.primary-action:hover {
  transform: translateY(-1px);
  box-shadow: 0 18px 30px rgba(244, 208, 0, 0.28);
}

.citizen-summary-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 18px;
}

.summary-card {
  padding: 22px;
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  display: grid;
  gap: 10px;
  box-shadow: var(--shadow);
}

.summary-card--highlight {
  background: linear-gradient(135deg, rgba(244, 208, 0, 0.12), rgba(255, 255, 255, 0.04));
  border-color: var(--accent-strong);
}

.summary-label,
.summary-meta,
.section-caption,
.report-card__meta span,
.report-card__footer,
.feedback-preview-card p {
  color: var(--text-muted);
}

.summary-label {
  font-size: 0.86rem;
}

.summary-value {
  font-size: 1.9rem;
  font-weight: 800;
  color: var(--text);
}

.summary-value.success {
  color: var(--success);
}

.summary-value.warning {
  color: var(--warning);
}

.summary-meta {
  font-size: 0.82rem;
}

.toolbar-panel {
  display: flex;
  justify-content: space-between;
  gap: 18px;
  padding: 20px 22px;
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow);
}

.toolbar-left {
  flex: 1;
}

.search-box {
  display: flex;
  align-items: center;
  gap: 12px;
  min-height: 52px;
  padding: 0 16px;
  border: 1px solid var(--border);
  border-radius: var(--radius-pill);
  background: var(--surface-soft);
}

.search-box svg {
  width: 18px;
  height: 18px;
  stroke: var(--text-faint);
  stroke-width: 2;
  fill: none;
  flex-shrink: 0;
}

.search-box input {
  width: 100%;
  border: none;
  outline: none;
  background: transparent;
  color: var(--text);
  font-size: 0.95rem;
}

.search-box input::placeholder {
  color: var(--text-faint);
}

.toolbar-right {
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-end;
  gap: 10px;
}

.filter-chip {
  min-height: 44px;
  padding: 0 16px;
  border-radius: var(--radius-pill);
  border: 1px solid var(--border);
  background: transparent;
  color: var(--text-muted);
  font-size: 0.88rem;
  font-weight: 600;
  cursor: pointer;
  transition: border-color 180ms ease, background 180ms ease, color 180ms ease;
}

.filter-chip:hover,
.filter-chip--active {
  color: var(--text);
  background: var(--accent-soft);
  border-color: var(--accent-strong);
}

.reports-section,
.feedback-preview-panel {
  display: grid;
  gap: 18px;
}

.section-heading {
  display: flex;
  align-items: end;
  justify-content: space-between;
  gap: 16px;
}

.section-heading--compact {
  align-items: center;
}

.section-heading h2 {
  font-size: 1.5rem;
}

.section-caption {
  font-size: 0.88rem;
}

.reports-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 18px;
}

.report-card {
  display: grid;
  gap: 18px;
  padding: 22px;
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow);
  transition: transform 180ms ease, border-color 180ms ease, background 180ms ease;
}

.report-card--feedback {
  cursor: pointer;
}

.report-card--feedback:hover {
  transform: translateY(-3px);
  border-color: var(--accent-strong);
  background: rgba(26, 33, 48, 0.98);
}

.report-card__top,
.report-card__footer,
.feedback-preview-card__header,
.feedback-meta-grid {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  flex-wrap: wrap;
}

.status-badge,
.priority-badge,
.feedback-state {
  display: inline-flex;
  align-items: center;
  min-height: 32px;
  padding: 0 12px;
  border-radius: var(--radius-pill);
  font-size: 0.74rem;
  font-weight: 700;
  letter-spacing: 0.04em;
  text-transform: uppercase;
}

.status-badge--feedback {
  background: var(--success-soft);
  color: var(--success);
}

.status-badge--pending {
  background: var(--warning-soft);
  color: var(--warning);
}

.priority-badge--high {
  background: var(--danger-soft);
  color: var(--danger);
}

.priority-badge--medium {
  background: rgba(255, 184, 77, 0.12);
  color: #ffc15d;
}

.priority-badge--low {
  background: rgba(83, 209, 139, 0.12);
  color: #7ce4a9;
}

.report-card__body {
  display: grid;
  gap: 10px;
}

.report-card__body h3 {
  margin: 0;
  font-size: 1.08rem;
  line-height: 1.35;
}

.report-card__body p,
.feedback-preview-card p {
  margin: 0;
  font-size: 0.93rem;
  line-height: 1.7;
}

.report-card__meta {
  display: grid;
  gap: 8px;
  padding-top: 4px;
  border-top: 1px solid var(--border);
}

.report-card__meta span {
  font-size: 0.84rem;
}

.report-card__footer {
  padding-top: 2px;
  color: var(--accent);
  font-weight: 600;
}

.report-card__footer--muted {
  color: var(--text-faint);
}

.feedback-hint {
  color: var(--accent);
}

.feedback-icon {
  font-size: 1.1rem;
  color: var(--accent);
}

.feedback-preview-card {
  padding: 24px;
  background: var(--surface-strong);
  border: 1px solid var(--border);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow);
  display: grid;
  gap: 22px;
}

.feedback-state {
  background: var(--accent-soft);
  color: var(--accent);
}

.feedback-preview-card__content {
  display: grid;
  gap: 20px;
}

.feedback-block {
  display: grid;
  gap: 10px;
}

.feedback-meta-grid {
  justify-content: flex-start;
  gap: 16px;
}

.feedback-meta-item {
  min-width: 180px;
  padding: 16px;
  background: var(--surface-soft);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  display: grid;
  gap: 8px;
}

.feedback-meta-item strong {
  font-size: 0.98rem;
  color: var(--text);
}

@media (max-width: 1100px) {
  .citizen-summary-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }

  .toolbar-panel,
  .citizen-header {
    flex-direction: column;
    align-items: stretch;
  }

  .toolbar-right {
    justify-content: flex-start;
  }
}

@media (max-width: 720px) {
  .citizen-page {
    padding: 18px;
  }

  .citizen-summary-grid {
    grid-template-columns: 1fr;
  }

  .citizen-header,
  .toolbar-panel,
  .summary-card,
  .report-card,
  .feedback-preview-card {
    padding: 18px;
  }

  .section-heading,
  .report-card__top,
  .report-card__footer,
  .feedback-preview-card__header,
  .feedback-meta-grid {
    align-items: flex-start;
    flex-direction: column;
  }

  .filter-chip,
  .primary-action {
    width: 100%;
    justify-content: center;
  }
}
</style>
