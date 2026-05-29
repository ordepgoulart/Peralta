<template>
    <div class="denuncia-card-wrapper" @click="handleClick">
        <div class="folder-tab"></div>
        <article class="denuncia-card">
            <div class="card-top">
                <div class="badges-group">
                    <span class="badge" :class="urgenciaClass">
                        {{ urgenciaLabel }}
                    </span>
                    <span v-if="denuncia.feedback" class="badge badge--feedback">
                        Respondido
                    </span>
                </div>
                <span class="card-date">
                    {{ formattedDate }}
                </span>
            </div>
            <div class="card-content">
                <p class="card-text">
                    {{ truncatedText }}
                </p>
            </div>
            <div class="card-actions">
                <button
                    class="btn-action btn-feedback"
                    :class="{ 'btn-disabled': denuncia.feedback }"
                    @click.stop="!denuncia.feedback && handleFeedback()"
                    :title="denuncia.feedback ? 'Feedback já enviado' : 'Adicionar feedback'"
                    :disabled="!!denuncia.feedback"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
                    </svg>
                    Feedback
                </button>
                <button
                    class="btn-action btn-delete"
                    @click.stop="handleDelete"
                    title="Deletar denúncia"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="3 6 5 6 21 6"/>
                        <path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/>
                        <path d="M10 11v6M14 11v6"/>
                        <path d="M9 6V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2"/>
                    </svg>
                    Deletar
                </button>
            </div>
        </article>
    </div>
</template>

<script>
export default
{
    name: 'DenunciaCardAdmin',
    props:
        {
            denuncia:
                {
                    type: Object,
                    required: true
                }
        },
    emits:
        [
            'select',
            'feedback',
            'delete'
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
            urgenciaLabel()
            {
                const mapa =
                    {
                        1: 'Baixa urgência',
                        2: 'Média urgência',
                        3: 'Alta urgência',
                        4: 'Muito Alta',
                        5: 'Crítica'
                    };
                return mapa[this.denuncia?.urgencia] || 'Sem urgência';
            },
            urgenciaClass()
            {
                const mapa =
                    {
                        1: 'badge--neutral',
                        2: 'badge--success',
                        3: 'badge--warning',
                        4: 'badge--alert',
                        5: 'badge--danger'
                    };
                return mapa[this.denuncia?.urgencia] || 'badge--neutral';
            },
            truncatedText()
            {
                const texto = this.denuncia?.texto || 'Sem descrição informada.';
                if (texto.length > 90)
                {
                    return texto.substring(0, 90) + '...';
                }
                return texto;
            }
        },
    methods:
        {
            handleClick()
            {
                this.$emit('select', this.denuncia);
            },
            handleFeedback()
            {
                this.$emit('feedback', this.denuncia);
            },
            handleDelete()
            {
                this.$emit('delete', this.denuncia);
            }
        }
};
</script>

<style scoped>
.denuncia-card-wrapper
{
    position: relative;
    padding-top: 14px;
    cursor: pointer;
    display: flex;
    flex-direction: column;
    height: 100%;
    transition: transform 0.25s cubic-bezier(0.2, 0.8, 0.2, 1);
}

.denuncia-card-wrapper:hover
{
    transform: translateY(-4px) scale(1.02);
}

.denuncia-card-wrapper:hover .denuncia-card,
.denuncia-card-wrapper:hover .folder-tab
{
    border-color: #2b3a5c;
}

.denuncia-card-wrapper:hover .denuncia-card
{
    box-shadow: 0 16px 40px rgba(0, 0, 0, 0.6);
}

.folder-tab
{
    position: absolute;
    top: 0;
    left: 0;
    width: 100px;
    height: 16px;
    background: #181821;
    border: 1px solid #1b253b;
    border-bottom: none;
    border-radius: 12px 12px 0 0;
    z-index: 3;
    transition: border-color 0.25s ease;
}

.folder-tab::after
{
    content: "";
    position: absolute;
    bottom: -2px;
    left: 0;
    width: 100%;
    height: 4px;
    background: #181821;
}

.denuncia-card
{
    position: relative;
    z-index: 2;
    background: #181821;
    border: 1px solid #1b253b;
    border-radius: 0 12px 12px 12px;
    padding: 22px;
    display: flex;
    flex-direction: column;
    gap: 16px;
    flex-grow: 1;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
    transition: border-color 0.25s ease, box-shadow 0.25s ease;
}

.card-top
{
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.badges-group
{
    display: flex;
    gap: 8px;
    align-items: center;
}

.badge
{
    padding: 6px 10px;
    border-radius: 6px;
    font-size: 0.75rem;
    font-weight: 800;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.badge--neutral  { background: rgba(168, 151, 255, 0.10); color: #a897ff; }
.badge--success  { background: rgba(217, 214, 194, 0.08); color: #d9d6c2; }
.badge--warning  { background: rgba(243, 223, 19,  0.08); color: #f3df13; }
.badge--alert    { background: rgba(255, 109,   0, 0.10); color: #FF6D00; }
.badge--danger   { background: rgba(255, 102, 113, 0.08); color: #ff6671; }

.badge--feedback
{
    background: rgba(99, 179, 237, 0.10);
    color: #63b3ed;
}

.card-date
{
    font-size: 0.8rem;
    color: rgba(255, 255, 255, 0.5);
    font-weight: 700;
}

.card-content
{
    flex-grow: 1;
}

.card-text
{
    margin: 0;
    font-size: 0.95rem;
    color: #c8c8d1;
    line-height: 1.5;
}

.card-actions
{
    display: flex;
    justify-content: space-between;
    gap: 8px;
    padding-top: 1rem;
    border-top: 1px solid rgba(255, 255, 255, 0.06);
}

.btn-action
{
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 6px 12px;
    border-radius: 8px;
    font-size: 0.75rem;
    font-weight: 700;
    letter-spacing: 0.3px;
    border: 1px solid transparent;
    cursor: pointer;
    transition: background 0.2s ease, border-color 0.2s ease, color 0.2s ease;
    text-transform: uppercase;
}

.btn-feedback
{
    background: rgba(99, 179, 237, 0.08);
    color: #63b3ed;
    border-color: rgba(99, 179, 237, 0.15);
}

.btn-feedback:hover:not(.btn-disabled)
{
    background: rgba(99, 179, 237, 0.18);
    border-color: rgba(99, 179, 237, 0.35);
}

.btn-delete
{
    background: rgba(255, 102, 113, 0.08);
    color: #ff6671;
    border-color: rgba(255, 102, 113, 0.15);
}

.btn-delete:hover
{
    background: rgba(255, 102, 113, 0.18);
    border-color: rgba(255, 102, 113, 0.35);
}

.btn-disabled
{
    opacity: 0.5;
    cursor: not-allowed;
    background: rgba(255, 255, 255, 0.05) !important;
    color: rgba(255, 255, 255, 0.3) !important;
    border-color: rgba(255, 255, 255, 0.1) !important;
}
</style>