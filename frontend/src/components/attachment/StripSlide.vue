<script setup>
    defineProps({
        height: { type: String, default: '40px' }
    });
</script>

<template>
    <div class="tape-container" :style="{ height: height }">
        <div class="tape-track">
            <div class="tape-segment" v-for="i in 18" :key="i">
                <div class="stripe"></div>
                <div class="stripe field"></div>
                <div class="stripe"></div>
                <div class="stripe field"></div>
            </div>
        </div>
    </div>
</template>

<style scoped>
    .tape-container
    {
        width: 100%;
        overflow: hidden;
        background: var(--bg);
        border-top: 2px solid var(--border);
        border-bottom: 2px solid var(--border);
        padding: 8px 0;
        display: flex;
        align-items: center;
        position: relative;
    }

    .tape-track
    {
        display: flex;
        width: max-content;
        animation: slide 14s linear infinite;
        height: 100%;
    }

    .tape-segment
    {
        display: flex;
        align-items: center;
        gap: 14px;
        padding-right: 14px;
    }

    .stripe
    {
        width: 60px;
        height: 100%;
        min-height: 100%;
        border: 2px solid var(--accent);
        transform: skewX(-25deg);
        background: transparent;
        flex-shrink: 0;
    }

    .stripe.field
        { background-color: var(--accent); }

    @keyframes slide
    {
        from
            { transform: translateX(0); }

        to
            { transform: translateX(-50%); }
    }

    @media (max-width: 768px)
    {
        .stripe
            { width: 40px; }

        .tape-segment
        {
            gap: 10px;
            padding-right: 10px;
        }
    }
</style>