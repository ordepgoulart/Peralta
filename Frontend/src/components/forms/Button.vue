<script setup>
    defineProps({
        type: {
            type: String,
            default: 'button'
        }
    });
</script>

<template>
    <button :type="type" class="custom-btn">
        <slot />
    </button>
</template>

<style scoped>
    .custom-btn
    {
        padding: 18px;
        border-radius: 8px;
        border: none;
        background: var(--accent);
        color: #000;
        font-weight: 600;
        letter-spacing: 1.2px;
        text-transform: uppercase;
        cursor: pointer;
        transition: transform 0.2s, opacity 0.2s;
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }

    .custom-btn:hover
    {
        opacity: 0.9;
        transform: translateY(-1px);
    }

    .custom-btn:active
    {
        transform: translateY(0);
    }
</style>