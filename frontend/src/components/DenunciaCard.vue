<template>
    <div class="denuncia-card-wrapper" @click="handleClick">
        <div class="folder-tab"></div>
        <article class="denuncia-card">
            <div class="card-top">
                <span class="badge" :class="urgenciaClass">
                    {{ urgenciaLabel }}
                </span>
                <span class="card-date">
                    {{ formattedDate }}
                </span>
            </div>
            <div class="card-content">
                <p class="card-text">
                    {{ truncatedText }}
                </p>
            </div>
        </article>
    </div>
</template>

<script>
export default
{
    name: 'DenunciaCard',
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
            'select'
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

.badge
{
    padding: 6px 10px;
    border-radius: 6px;
    font-size: 0.75rem;
    font-weight: 800;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.badge--neutral
{
    background: rgba(168, 151, 255, 0.10);
    color: #a897ff;
}

.badge--success
{
    background: rgba(217, 214, 194, 0.08);
    color: #d9d6c2;
}

.badge--warning
{
    background: rgba(243, 223, 19, 0.08);
    color: #f3df13;
}

.badge--alert
{
    background: rgba(255, 109, 0, 0.10);
    color: #FF6D00;
}

.badge--danger
{
    background: rgba(255, 102, 113, 0.08);
    color: #ff6671;
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
</style>