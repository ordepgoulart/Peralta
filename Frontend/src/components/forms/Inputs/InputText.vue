<script setup>
    import { computed, ref } from 'vue';

    const props = defineProps(
    {
        modelValue: { type: String, default: '' },
        label: String,
        placeholder: String,
        mask: Function,
        validator: [Function, Array]
    });

    const emit = defineEmits(['update:modelValue']);

    const touched = ref(false);

    const handle_input = (event) =>
    {
        touched.value = true;
        let value = event.target.value;

        if (props.mask)
        {
            value = props.mask(value);
            event.target.value = value;
        }

        emit('update:modelValue', value);
    };

    const is_valid = computed(() =>
    {
        if (!touched.value)
            return true;

        if (!props.validator)
            return true;

        if (Array.isArray(props.validator))
            return props.validator.every(fn => fn(props.modelValue));

        return props.validator(props.modelValue);
    });
</script>

<template>
    <div class="input-group">
        <label v-if="label">{{ label }}</label>

        <input
            type="text"
            :value="modelValue"
            :placeholder="placeholder"
            :class="{ invalid: !is_valid }"
            @input="handle_input"
        />
    </div>
</template>

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

    input
    {
        padding: 18px;
        border-radius: 8px;
        border: 1px solid var(--border);
        background: var(--bg);
        color: var(--text);
        outline: none;
        transition: border-color 0.3s;
        font-size: .9em;
    }

    input:focus
        { border-color: var(--accent); }

    .invalid
        { border-color: #ff4d4d; }
</style>