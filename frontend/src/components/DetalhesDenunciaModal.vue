<template>
    <div v-if="show" class="modal-overlay" @click.self="fecharModal">
        <section class="modal-box">
            <div class="modal-header">
                <div>
                    <span class="modal-kicker">Detalhes da Ocorrência</span>
                    <h2>{{ denuncia?.titulo || 'Denúncia' }}</h2>
                </div>
                <button class="close-btn" @click="fecharModal">
                    &times;
                </button>
            </div>
            <div class="modal-body">
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Data</span>
                        <strong>{{ formattedDate }}</strong>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Órgão Responsável</span>
                        <strong>{{ denuncia?.orgao?.nome || 'Não informado' }}</strong>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Tipo</span>
                        <strong>{{ denuncia?.tipo?.nome || 'Não informado' }}</strong>
                    </div>
                </div>
                <div class="content-block">
                    <span class="info-label">Descrição Detalhada</span>
                    <p class="description-text">{{ denuncia?.texto || 'Sem descrição.' }}</p>
                </div>
                <div v-if="hasFotos" class="content-block">
                    <span class="info-label">Imagens Anexadas</span>
                    <div class="gallery-grid">
                        <img v-for="(foto, index) in denuncia.fotos" :key="index" :src="getFotoUrl(foto)" class="gallery-img" />
                    </div>
                </div>
                <div v-if="feedback" class="feedback-block">
                    <div class="feedback-header">
                        <span class="info-label">Feedback do Órgão</span>
                        <span class="feedback-date">{{ feedback.dataResposta || feedback.data }}</span>
                    </div>
                    <p class="feedback-text">{{ feedback.mensagem || feedback.resposta }}</p>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
export default
{
    name: "DetalhesDenunciaModal",
    props:
        {
            show:
                {
                    type: Boolean,
                    default: false
                },
            denuncia:
                {
                    type: Object,
                    default: () => ({})
                },
            feedback:
                {
                    type: Object,
                    default: null
                },
            imageBaseUrl:
                {
                    type: String,
                    default: 'http://localhost:8080/uploads/'
                }
        },
    emits:
        [
            "close"
        ],
    computed:
        {
            formattedDate()
            {
                if (!this.denuncia?.data)
                {
                    return 'Data não informada';
                }

                const data = new Date(this.denuncia.data);

                if (Number.isNaN(data.getTime()))
                {
                    return this.denuncia.data;
                }

                return data.toLocaleDateString('pt-BR');
            },
            hasFotos()
            {
                return Array.isArray(this.denuncia?.fotos) && this.denuncia.fotos.length > 0;
            }
        },
    methods:
        {
            fecharModal()
            {
                this.$emit("close");
            },
            getFotoUrl(foto)
            {
                const arquivo = foto?.arquivo || foto?.nome || foto?.url || '';

                if (arquivo.startsWith('http://') || arquivo.startsWith('https://'))
                {
                    return arquivo;
                }

                return `${this.imageBaseUrl}${arquivo}`;
            }
        }
};
</script>

<style scoped>
.modal-overlay
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
    overflow-y: hidden;
}

.modal-box
{
    width: 100%;
    max-width: 800px;
    max-height: 90vh;
    background: #050507;
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 16px;
    display: flex;
    flex-direction: column;
    box-shadow: 0 24px 64px rgba(0, 0, 0, 0.8);
    overflow: hidden;
}

.modal-header
{
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    padding: 24px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
    background: #0a0a0f;
}

.modal-kicker
{
    display: block;
    color: #f3df13;
    font-size: 0.8rem;
    text-transform: uppercase;
    font-weight: 800;
    letter-spacing: 1px;
    margin-bottom: 8px;
}

.modal-header h2
{
    margin: 0;
    color: #ffffff;
    font-size: 1.6rem;
    font-weight: 800;
}

.close-btn
{
    background: transparent;
    border: none;
    color: #ffffff;
    font-size: 2rem;
    cursor: pointer;
    line-height: 1;
    transition: opacity 0.2s;
}

.close-btn:hover
{
    opacity: 0.6;
}

.modal-body
{
    padding: 24px;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
    gap: 24px;
    flex-grow: 1;
}

.info-grid
{
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 16px;
    padding: 16px;
    background: rgba(255, 255, 255, 0.02);
    border-radius: 12px;
    border: 1px solid rgba(255, 255, 255, 0.04);
}

.info-item
{
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.info-label
{
    font-size: 0.75rem;
    text-transform: uppercase;
    font-weight: 800;
    letter-spacing: 1px;
    color: rgba(255, 255, 255, 0.4);
}

.info-item strong
{
    color: #ffffff;
    font-size: 1rem;
}

.content-block
{
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.description-text
{
    margin: 0;
    color: #c8c8d1;
    line-height: 1.6;
    font-size: 1rem;
}

.gallery-grid
{
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
    gap: 12px;
}

.gallery-img
{
    width: 100%;
    aspect-ratio: 1;
    object-fit: cover;
    border-radius: 8px;
    border: 1px solid rgba(255, 255, 255, 0.1);
}

.feedback-block
{
    background: rgba(243, 223, 19, 0.05);
    border: 1px solid rgba(243, 223, 19, 0.15);
    padding: 20px;
    border-radius: 12px;
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.feedback-header
{
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.feedback-header .info-label
{
    color: #f3df13;
}

.feedback-date
{
    font-size: 0.8rem;
    color: rgba(255, 255, 255, 0.5);
    font-weight: 700;
}

.feedback-text
{
    margin: 0;
    color: #ffffff;
    line-height: 1.6;
}
</style>