<template>
    <div class="modal-overlay" v-if="show" @click.self="fecharModal">
        <div class="modal-container">
            <header class="modal-header">
                <h3>Nova Denúncia</h3>
                <button class="close-btn" @click="fecharModal">&times;</button>
            </header>
            <main class="modal-body">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="titulo">Título</label>
                        <input id="titulo" v-model="form.titulo" type="text" placeholder="Informe o título da denúncia" required />
                    </div>
                    <div class="form-group-row">
                        <div class="form-group">
                            <label for="orgao">Órgão</label>
                            <select id="orgao" v-model="form.orgao">
                                <option value="" disabled>Selecione um órgão</option>
                                <option v-for="orgao in orgaos" :key="orgao.id" :value="orgao.id">{{ orgao.nome }}</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="tipo">Tipo</label>
                            <select id="tipo" v-model="form.tipo">
                                <option value="" disabled>Selecione um tipo</option>
                                <option v-for="tipo in tipos" :key="tipo.id" :value="tipo.id">{{ tipo.nome }}</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="urgencia">Urgência</label>
                        <select id="urgencia" v-model="form.urgencia">
                            <option value="1">Baixa</option>
                            <option value="2">Média</option>
                            <option value="3">Alta</option>
                            <option value="4">Muito Alta</option>
                            <option value="5">Crítica</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="texto">Descrição</label>
                        <textarea id="texto" v-model="form.texto" rows="4" placeholder="Detalhe a situação ocorrida"></textarea>
                    </div>
                    <div class="form-group">
                        <label>Imagens (Opcional)</label>
                        <label class="drop-zone">
                            <span>Selecionar Imagens</span>
                            <input type="file" multiple accept="image/*" @change="lidarComUpload" />
                        </label>
                        <div class="preview-grid" v-if="previewFotos.length > 0">
                            <div v-for="(img, index) in previewFotos" :key="index" class="thumb">
                                <img :src="img" />
                                <button type="button" @click="removerImagem(index)" class="remove-btn">&times;</button>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <footer class="modal-footer">
                <button class="btn-cancel" @click="limparFormulario">Limpar</button>
                <button class="btn-confirm" @click="confirmarAcao">Enviar Denúncia</button>
            </footer>
        </div>
    </div>
</template>

<script>
export default
{
    name: "FormDenuncia",
    props:
        {
            show:
                {
                    type: Boolean,
                    default: false
                },
            orgaos:
                {
                    type: Array,
                    default: () => []
                },
            tipos:
                {
                    type: Array,
                    default: () => []
                }
        },
    emits:
        [
            "close",
            "confirm"
        ],
    data()
    {
        return {
            form:
                {
                    titulo: "",
                    tipo: "",
                    orgao: "",
                    urgencia: 1,
                    fotos: [],
                    fotosBase64: [],
                    texto: ""
                },
            previewFotos: []
        };
    },
    methods:
        {
            lidarComUpload(event)
            {
                const files = Array.from(event.target.files);

                files.forEach(file =>
                {
                    this.form.fotos.push(file);

                    const reader = new FileReader();
                    reader.onload = (e) =>
                    {
                        this.previewFotos.push(e.target.result);
                    };
                    reader.readAsDataURL(file);
                });
            },
            removerImagem(index)
            {
                this.previewFotos.splice(index, 1);
                this.form.fotos.splice(index, 1);
            },
            limparFormulario()
            {
                this.form.urgencia = 1;
                this.form.titulo = "";
                this.form.orgao = "";
                this.form.tipo = "";
                this.form.texto = "";
                this.form.fotos = [];
                this.form.fotosBase64 = [];
                this.previewFotos = [];
            },
            fecharModal()
            {
                this.limparFormulario();
                this.$emit("close");
            },
            confirmarAcao()
            {
                this.form.fotosBase64 = this.previewFotos;
                this.$emit("confirm", this.form);
                this.fecharModal();
            }
        }
};
</script>

<style scoped>
*, *::before, *::after
{
    box-sizing: border-box;
}

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
}

.modal-container
{
    width: 100%;
    max-width: 650px;
    max-height: 90vh;
    background: #050507;
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 16px;
    box-shadow: 0 24px 64px rgba(0, 0, 0, 0.8);
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

.modal-header
{
    padding: 24px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #0a0a0f;
    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
    flex-shrink: 0;
}

.modal-header h3
{
    margin: 0;
    color: #ffffff;
    text-transform: uppercase;
    letter-spacing: 1.5px;
    font-size: 1.1rem;
    font-weight: 800;
}

.close-btn
{
    background: transparent;
    border: none;
    color: #ffffff;
    font-size: 1.8rem;
    cursor: pointer;
    line-height: 1;
    transition: opacity 0.2s;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0;
}

.close-btn:hover
{
    opacity: 0.6;
}

.modal-body
{
    padding: 24px;
    overflow-y: auto;
    flex-grow: 1;
    display: flex;
    flex-direction: column;
}

.form-top
{
    display: flex;
    flex-direction: column;
    gap: 6px;
    margin-bottom: 24px;
}

.form-top p
{
    margin: 0;
    font-size: 0.95rem;
    color: rgba(255, 255, 255, 0.6);
}

.form-grid
{
    display: flex;
    flex-direction: column;
    gap: 20px;
    width: 100%;
}

.form-group-row
{
    display: flex;
    gap: 20px;
    width: 100%;
}

.form-group-row .form-group
{
    flex: 1;
    min-width: 0;
}

.form-group
{
    display: flex;
    flex-direction: column;
    gap: 8px;
    width: 100%;
}

.form-group label
{
    font-size: 0.85rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: #ffffff;
}

.form-group input,
.form-group select,
.form-group textarea
{
    width: 100%;
    padding: 14px 16px;
    border-radius: 10px;
    border: 1px solid rgba(255, 255, 255, 0.1);
    background: rgba(255, 255, 255, 0.04);
    color: #ffffff;
    outline: none;
    font-size: 1rem;
    transition: border-color 0.25s ease, background 0.25s ease, box-shadow 0.25s ease;
    font-family: inherit;
}

.form-group textarea
{
    resize: vertical;
    min-height: 100px;
    max-height: 300px;
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus
{
    border-color: #f3df13;
    background: rgba(255, 255, 255, 0.08);
    box-shadow: 0 0 0 4px rgba(243, 223, 19, 0.1);
}

.form-group select option
{
    background: #0a0a0f;
    color: #ffffff;
}

.drop-zone
{
    font-size: 0.9rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    min-height: 90px;
    border: 1px dashed rgba(255, 255, 255, 0.25);
    border-radius: 10px;
    cursor: pointer;
    transition: 0.25s ease;
    background: rgba(255, 255, 255, 0.02);
    color: rgba(255, 255, 255, 0.7);
}

.drop-zone:hover
{
    border-color: #f3df13;
    background: rgba(243, 223, 19, 0.08);
    color: #f3df13;
}

.drop-zone input
{
    display: none;
}

.preview-grid
{
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
    gap: 12px;
    margin-top: 16px;
}

.thumb
{
    position: relative;
    aspect-ratio: 1;
    border-radius: 8px;
    overflow: hidden;
    border: 1px solid rgba(255, 255, 255, 0.15);
}

.thumb img
{
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.remove-btn
{
    position: absolute;
    top: 6px;
    right: 6px;
    background: rgba(0, 0, 0, 0.85);
    color: #ffffff;
    border: none;
    border-radius: 50%;
    width: 24px;
    height: 24px;
    font-size: 14px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background 0.2s, transform 0.2s;
}

.remove-btn:hover
{
    background: #ff4d57;
    transform: scale(1.1);
}

.modal-footer
{
    padding: 20px 24px;
    display: flex;
    gap: 16px;
    justify-content: flex-end;
    background: #0a0a0f;
    border-top: 1px solid rgba(255, 255, 255, 0.05);
    flex-shrink: 0;
}

.btn-cancel
{
    background: rgba(255, 255, 255, 0.05);
    color: #ffffff;
    border: 1px solid rgba(255, 255, 255, 0.15);
    padding: 12px 28px;
    border-radius: 10px;
    font-size: 0.95rem;
    font-weight: 700;
    cursor: pointer;
    transition: background 0.2s, border-color 0.2s;
}

.btn-cancel:hover
{
    background: rgba(255, 255, 255, 0.1);
    border-color: rgba(255, 255, 255, 0.25);
}

.btn-confirm
{
    background: linear-gradient(180deg, #f3df13, #dbc500);
    color: #000000;
    border: none;
    padding: 12px 28px;
    border-radius: 10px;
    font-size: 0.95rem;
    font-weight: 800;
    cursor: pointer;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    box-shadow: 0 4px 12px rgba(243, 223, 19, 0.2);
}

.btn-confirm:hover
{
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(243, 223, 19, 0.3);
}

@media (max-width: 600px)
{
    .form-group-row
    {
        flex-direction: column;
        gap: 20px;
    }

    .modal-container
    {
        height: 100%;
        max-height: 100vh;
        border-radius: 0;
    }

    .modal-overlay
    {
        padding: 0;
    }
}
</style>