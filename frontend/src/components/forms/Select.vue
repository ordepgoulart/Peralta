<template>
    <div class="input-group">
        <label v-if="label" :for="id">
            {{ label }}
            <span v-if="required" class="required-mark">*</span>
        </label>
        <div class="select-container">
            <select :id="id" :value="modelValue" @change="handle_change">
                <option value="" disabled>{{ placeholder }}</option>
                <option v-for="option in options" :key="option[valueKey]" :value="option[valueKey]">
                    {{ option[labelKey] }}
                </option>
            </select>
            <div class="arrow-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <polyline points="6 9 12 15 18 9"></polyline>
                </svg>
            </div>
        </div>
    </div>
</template>

<script>
export default
{
    name: "SelectField",
    props:
        {
            modelValue:
                {
                    type: [String, Number],
                    default: ""
                },
            id:
                {
                    type: String,
                    default: ""
                },
            label:
                {
                    type: String,
                    default: ""
                },
            placeholder:
                {
                    type: String,
                    default: "Selecione uma opção"
                },
            options:
                {
                    type: Array,
                    default: () => []
                },
            valueKey:
                {
                    type: String,
                    default: "id"
                },
            labelKey:
                {
                    type: String,
                    default: "nome"
                },
            required:
                {
                    type: Boolean,
                    default: false
                }
        },
    emits:
        [
            "update:modelValue"
        ],
    methods:
        {
            handle_change(event)
            {
                this.$emit("update:modelValue", event.target.value);
            }
        }
};
</script>

<style scoped>
.input-group
{
    display: flex;
    flex-direction: column;
    gap: 8px;
    width: 100%;
}

label
{
    font-size: 0.7em;
    font-weight: 600;
    letter-spacing: 1.5px;
    color: var(--text);
    text-transform: uppercase;
}

.required-mark
{
    color: var(--accent, #f3df13);
    margin-left: 4px;
}

.select-container
{
    position: relative;
    width: 100%;
}

select
{
    padding: 18px;
    padding-right: 48px;
    border-radius: 8px;
    border: 1px solid var(--border);
    background: var(--bg);
    color: var(--text);
    font-size: 1rem;
    outline: none;
    transition: border-color 0.2s;
    width: 100%;
    appearance: none;
}

select:focus
{
    border-color: var(--accent);
}

.arrow-icon
{
    position: absolute;
    right: 18px;
    top: 50%;
    transform: translateY(-50%);
    pointer-events: none;
    color: var(--text);
    opacity: 0.7;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 18px;
    height: 18px;
}

option
{
    background: var(--bg-2);
    color: var(--text);
}
</style>