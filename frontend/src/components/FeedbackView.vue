<template>
    <div v-if="feedback" class="feedback-modal-overlay" @click.self="fecharModal">
        <section class="feedback-modal">
            <div class="section-heading section-heading--compact">
                <div>
                    <span class="section-kicker">Área de visualização</span>
                    <h2>Preview do feedback</h2>
                </div>
                <button class="feedback-close-btn" @click="fecharModal">
                    &times;
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
export default
{
    name: "FeedbackModal",
    props:
        {
            feedback:
                {
                    type: Object,
                    default: null
                }
        },
    emits:
        ["close"],
    methods:
        {
            fecharModal()
            {
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
    background: rgba(0, 0, 0, 0.85);
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 24px;
    z-index: 3000;
    backdrop-filter: blur(8px);
}

.feedback-modal
{
    width: 100%;
    max-width: 760px;
    background: #000000;
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 16px;
    padding: 32px;
    box-shadow: 0 24px 64px rgba(0, 0, 0, 0.6);
}

.section-heading
{
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    border-bottom: 1px solid rgba(255, 255, 255, 0.08);
    padding-bottom: 16px;
    margin-bottom: 24px;
}

.section-kicker
{
    display: block;
    color: #f4d000;
    font-size: 0.8rem;
    text-transform: uppercase;
    font-weight: 800;
    letter-spacing: 1px;
    margin-bottom: 8px;
}

.section-heading h2
{
    margin: 0;
    color: #ffffff;
    font-size: 1.6rem;
    font-weight: 800;
}

.feedback-close-btn
{
    background: transparent;
    border: none;
    color: #ffffff;
    font-size: 2rem;
    cursor: pointer;
    line-height: 1;
    transition: opacity 0.2s;
}

.feedback-close-btn:hover
{
    opacity: 0.6;
}

.feedback-preview-card__header
{
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 16px;
    margin-bottom: 24px;
}

.feedback-preview-card__header h3
{
    margin: 0;
    color: #ffffff;
    font-size: 1.2rem;
    font-weight: 700;
}

.feedback-preview-card__content
{
    display: flex;
    flex-direction: column;
    gap: 24px;
}

.feedback-block p
{
    margin: 0;
    color: rgba(255, 255, 255, 0.8);
    line-height: 1.6;
    background: rgba(255, 255, 255, 0.04);
    padding: 16px;
    border-radius: 8px;
    border: 1px solid rgba(255, 255, 255, 0.05);
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
    font-size: 0.75rem;
    text-transform: uppercase;
    font-weight: 800;
    letter-spacing: 1px;
    color: rgba(255, 255, 255, 0.5);
    margin-bottom: 8px;
}

.feedback-state
{
    padding: 8px 14px;
    border-radius: 8px;
    background: rgba(244, 208, 0, 0.12);
    color: #f4d000;
    font-size: 0.8rem;
    font-weight: 800;
    text-transform: uppercase;
}

.feedback-meta-item strong
{
    color: #ffffff;
    font-size: 1rem;
}

@media (max-width: 768px)
{
    .feedback-meta-grid
    {
        grid-template-columns: 1fr;
    }
}
</style>