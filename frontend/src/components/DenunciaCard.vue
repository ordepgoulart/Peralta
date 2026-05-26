<template>
  <article
    class="denuncia-card denuncia-card--clickable"
    :class="`denuncia-card--urgencia-${denuncia?.urgencia || 0}`"
    @click="handleClick"
  >
    <div class="card-top">
      <div class="status-group">
        <span class="badge badge--tipo">
          {{ denuncia?.tipo?.nome || 'Tipo não informado' }}
        </span>

        <span class="badge" :class="urgenciaClass">
          {{ urgenciaLabel }}
        </span>
      </div>

      <span class="card-date">
        {{ formattedDate }}
      </span>
    </div>

    <div class="card-gallery" v-if="hasFotos">
      <img
        class="gallery-cover"
        :src="fotoPrincipalUrl"
        :alt="`Foto da denúncia ${denuncia?.titulo || ''}`"
      />

      <div class="gallery-counter" v-if="fotoCount > 1">
        +{{ fotoCount - 1 }} fotos
      </div>
    </div>

    <div class="card-gallery card-gallery--empty" v-else>
      <div class="gallery-placeholder">
        <svg viewBox="0 0 24 24" aria-hidden="true">
          <path d="M4 5h16a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V6a1 1 0 0 1 1-1Zm0 0 4 5 3-3 6 8" />
          <circle cx="16.5" cy="8.5" r="1.5" />
        </svg>
        <span>Sem imagens</span>
      </div>
    </div>

    <div class="card-content">
      <h3 class="card-title">{{ denuncia?.titulo || 'Sem título' }}</h3>

      <p class="card-text">
        {{ denuncia?.texto || 'Sem descrição informada.' }}
      </p>
    </div>

    <div class="card-meta">
      <div class="meta-item">
        <span class="meta-label">Órgão</span>
        <strong>{{ denuncia?.orgao?.nome || 'Não informado' }}</strong>
      </div>

      <div class="meta-item">
        <span class="meta-label">Autor</span>
        <strong>{{ denuncia?.usuario?.nome || denuncia?.usuario?.email || 'Usuário' }}</strong>
      </div>
    </div>

    <footer class="card-footer">
      <div class="footer-left">
        <span class="foto-chip">
          {{ fotoCount }} {{ fotoCount === 1 ? 'foto' : 'fotos' }}
        </span>
      </div>

      <div class="footer-right">
        <span class="feedback-link">Ver feedback</span>
        <span class="feedback-arrow">→</span>
      </div>
    </footer>
  </article>
</template>

<script>
export default {
  name: 'DenunciaCard',
  props: {
    denuncia: {
      type: Object,
      required: true
    },
    imageBaseUrl: {
      type: String,
      default: '/uploads/'
    }
  },
  emits: ['select'],
  computed: {
    formattedDate() {
      if (!this.denuncia?.data) return 'Data não informada';

      const data = new Date(this.denuncia.data);
      if (Number.isNaN(data.getTime())) return this.denuncia.data;

      return data.toLocaleDateString('pt-BR');
    },
    urgenciaLabel() {
      const mapa = {
        1: 'Baixa urgência',
        2: 'Média urgência',
        3: 'Alta urgência'
      };
      return mapa[this.denuncia?.urgencia] || 'Sem urgência';
    },
    urgenciaClass() {
      const mapa = {
        1: 'badge--success',
        2: 'badge--warning',
        3: 'badge--danger'
      };
      return mapa[this.denuncia?.urgencia] || 'badge--neutral';
    },
    fotoCount() {
      return Array.isArray(this.denuncia?.fotos) ? this.denuncia.fotos.length : 0;
    },
    hasFotos() {
      return this.fotoCount > 0;
    },
    fotoPrincipalUrl() {
      if (!this.hasFotos) return '';

      const foto = this.denuncia.fotos[0];
      const arquivo = foto?.arquivo || foto?.nome || foto?.url || '';

      if (!arquivo) return '';
      if (arquivo.startsWith('http://') || arquivo.startsWith('https://')) return arquivo;

      return `${this.imageBaseUrl}${arquivo}`;
    }
  },
  methods: {
    handleClick() {
      this.$emit('select', this.denuncia);
    }
  }
};
</script>

<style scoped>
  .denuncia-card {
  --surface: rgba(16, 22, 32, 0.96);
  --surface-soft: rgba(255, 255, 255, 0.045);
  --border: rgba(255, 255, 255, 0.08);
  --text: #f4f7fb;
  --text-muted: #a8b2c3;
  --text-faint: #7f8998;
  --accent: #f4d000;
  --accent-soft: rgba(244, 208, 0, 0.16);
  --success: #51cf88;
  --success-soft: rgba(81, 207, 136, 0.14);
  --warning: #ffbc52;
  --warning-soft: rgba(255, 188, 82, 0.14);
  --danger: #ff7d7d;
  --danger-soft: rgba(255, 125, 125, 0.15);
  position: relative;
  display: grid;
  gap: 16px;
  padding: 18px;
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: 20px;
  box-shadow: 0 18px 36px rgba(0, 0, 0, 0.22);
  overflow: hidden;
  transition: transform 180ms ease, border-color 180ms ease, background 180ms ease;
  cursor: pointer;
}

.denuncia-card:hover {
  transform: translateY(-3px);
  border-color: rgba(244, 208, 0, 0.22);
  background: rgba(21, 28, 40, 0.98);
}
</style>

