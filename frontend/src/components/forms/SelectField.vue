<template>
    <div class="input-group">
        <label v-if="label" :for="id">{{ label }}</label>
        <select :id="id" :value="modelValue" @change="handle_change">
            <option value="" disabled>{{ placeholder }}</option>
            <option v-for="option in options" :key="option[valueKey]" :value="option[valueKey]">
                {{ option[labelKey] }}
            </option>
        </select>
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

select
{
    padding: 18px;
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

option
{
    background: var(--bg-2);
    color: var(--text);
}
</style>