<template>
    <div class="modal-overlay" v-if="show" @click.self="fecharModal">
        <div class="modal-container">
            <header class="modal-header">
                <h3>
                    {{ title }}
                </h3>
                <button class="close-btn" @click="fecharModal">
                    &times;
                </button>
            </header>
            <main class="modal-body">
                <div class="form-grid">
                    <RowDivision v-for="(row, rowIndex) in schema" :key="rowIndex" :cols="row.fields.length">
                        <template v-for="(field, fieldIndex) in row.fields" :key="fieldIndex">
                            <InputText
                                v-if="field.type === 'text'"
                                v-model="formData[field.name]"
                                :label="field.label"
                                :placeholder="field.placeholder"
                                :mask="field.mask"
                                :validator="field.validator"
                                :required="field.required"
                            />

                            <InputText
                                v-else-if="field.type === 'textarea'"
                                v-model="formData[field.name]"
                                :label="field.label"
                                :placeholder="field.placeholder"
                                :mask="field.mask"
                                :validator="field.validator"
                                :multiline="true"
                                :required="field.required"
                            />

                            <SelectInput
                                v-else-if="field.type === 'select'"
                                v-model="formData[field.name]"
                                :label="field.label"
                                :options="field.options"
                                :placeholder="field.placeholder"
                                :validator="field.validator"
                                :required="field.required"
                            />

                            <InputFile
                                v-else-if="field.type === 'file'"
                                v-model="formData[field.name]"
                                :label="field.label"
                                :required="field.required"
                            />
                        </template>
                    </RowDivision>
                </div>
            </main>
            <footer class="modal-footer">
                <Button class="btn-cancel" @click="limparFormulario">
                    Limpar
                </Button>
                <Button class="btn-confirm" @click="confirmarAcao">
                    Enviar
                </Button>
            </footer>
        </div>
    </div>
</template>

<script>
import InputText from "./InputText.vue";
import SelectInput from "./Select.vue";
import InputFile from "./InputFile.vue";
import RowDivision from "./RowDivision.vue";
import Button from "../ui/Button.vue";

export default
{
    name: "Form",
    components:
        {
            InputText,
            SelectInput,
            InputFile,
            RowDivision,
            Button
        },
    props:
        {
            show:
                {
                    type: Boolean,
                    default: false
                },
            title:
                {
                    type: String,
                    default: "Formulário"
                },
            schema:
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
            formData: {}
        };
    },
    watch:
        {
            show(val)
            {
                if (val)
                {
                    this.initFormData();
                }
            }
        },
    methods:
        {
            initFormData()
            {
                const data = {};

                this.schema.forEach(row =>
                {
                    row.fields.forEach(field =>
                    {
                        if (field.type === 'file')
                        {
                            data[field.name] = [];
                        }
                        else
                        {
                            data[field.name] = "";
                        }
                    });
                });

                this.formData = data;
            },
            fecharModal()
            {
                this.limparFormulario();
                this.$emit("close");
            },
            limparFormulario()
            {
                this.initFormData();
            },
            confirmarAcao()
            {
                this.$emit("confirm", { ...this.formData });
                this.fecharModal();
            }
        },
    mounted()
    {
        this.initFormData();
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
    --bg: #0a0a0f;
    --background-secondary: rgba(255, 255, 255, 0.04);
    --border: rgba(255, 255, 255, 0.1);
    --text: #ffffff;
    --accent: #f3df13;

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
    background: var(--bg);
    border-bottom: 1px solid var(--border);
    flex-shrink: 0;
}

.modal-header h3
{
    margin: 0;
    color: var(--text);
    text-transform: uppercase;
    letter-spacing: 1.5px;
    font-size: 1.1rem;
    font-weight: 800;
}

.close-btn
{
    background: transparent;
    border: none;
    color: var(--text);
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

.form-grid
{
    display: flex;
    flex-direction: column;
    width: 100%;
}

.modal-footer
{
    padding: 20px 24px;
    display: flex;
    gap: 16px;
    justify-content: flex-end;
    background: var(--bg);
    border-top: 1px solid var(--border);
    flex-shrink: 0;
}

.btn-cancel
{
    background: rgba(255, 255, 255, 0.05) !important;
    color: #ffffff !important;
    border: 1px solid rgba(255, 255, 255, 0.15) !important;
}

.btn-cancel:hover
{
    background: rgba(255, 255, 255, 0.1) !important;
    border-color: rgba(255, 255, 255, 0.25) !important;
}

.btn-confirm
{
    background: linear-gradient(180deg, #f3df13, #dbc500) !important;
    color: #000000 !important;
    box-shadow: 0 4px 12px rgba(243, 223, 19, 0.2) !important;
}

.btn-confirm:hover
{
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(243, 223, 19, 0.3) !important;
}

@media (max-width: 600px)
{
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