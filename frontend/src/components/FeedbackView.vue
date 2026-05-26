<template>
  <div
    v-if="feedback"
    class="feedback-modal-overlay"
    @click.self="fecharModal"
  >
    <section class="feedback-modal">
      <div class="section-heading section-heading--compact">
        <div>
          <span class="section-kicker">Área de visualização</span>
          <h2>Preview do feedback</h2>
        </div>

        <button class="feedback-close-btn" @click="fecharModal">
          ×
        </button>
      </div>

      <article class="feedback-preview-card">
        <div class="feedback-preview-card__header">
          <div>
            <span class="feedback-label">Denúncia selecionada</span>
            <h3>{{ feedback.denuncia?.titulo || feedback.titulo }}</h3>
          </div>

          <span class="feedback-state">Feedback disponível</span>
        </div>

        <div class="feedback-preview-card__content">
          <div class="feedback-block">
            <span class="feedback-label">Resposta do órgão</span>
            <p>{{ feedback.mensagem || feedback.resposta }}</p>
          </div>

          <div class="feedback-meta-grid">
            <div class="feedback-meta-item">
              <span class="feedback-label">Órgão</span>
              <strong>{{ feedback.orgaoResponsavel || feedback.orgao }}</strong>
            </div>

            <div class="feedback-meta-item">
              <span class="feedback-label">Data da resposta</span>
              <strong>{{ feedback.dataResposta || feedback.data }}</strong>
            </div>
          </div>
        </div>
      </article>
    </section>
  </div>
</template>

<script>
export default {
  name: "FeedbackModal",
  props: {
    feedback: {
      type: Object,
      default: null
    }
  },
  emits: ["close"],
  methods: {
    fecharModal() {
      this.$emit("close");
    }
  }
};
</script>

<style scoped>
.feedback-modal-overlay
{
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.65);
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 24px;
    z-index: 3000;
    backdrop-filter: blur(4px);
}

.feedback-modal
{
    width: 100%;
    max-width: 760px;
    background: #111;
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 20px;
    padding: 24px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.45);
}

.feedback-close-btn
{
    background: transparent;
    border: none;
    color: #fff;
    font-size: 2rem;
    cursor: pointer;
    line-height: 1;
}

.feedback-preview-card
{
    margin-top: 16px;
}

.feedback-preview-card__header
{
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 16px;
    margin-bottom: 20px;
}

.feedback-preview-card__content
{
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.feedback-meta-grid
{
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 16px;
}

.feedback-label
{
    display: block;
    font-size: 0.8rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    opacity: 0.7;
    margin-bottom: 6px;
}

.feedback-state
{
    padding: 8px 12px;
    border-radius: 999px;
    background: rgba(255, 215, 0, 0.12);
    color: #ffd700;
    font-size: 0.85rem;
    font-weight: 700;
}

@media (max-width: 768px)
{
    .feedback-meta-grid
    {
        grid-template-columns: 1fr;
    }
}
</style>