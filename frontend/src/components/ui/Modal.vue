<script setup>
    import Button from "./Button.vue";
    import StripSlide from "./StripSlide.vue";

    defineProps(
        {
            show: Boolean,
            title: String
        });

    defineEmits(['close', 'confirm']);
</script>

<template>
    <div class="modal-overlay" v-if="show" @click.self="$emit('close')">
        <div class="modal-container">
            <StripSlide height="35px" />

            <header class="modal-header">
                <h3>{{ title }}</h3>
                <button class="close-btn" @click="$emit('close')">&times;</button>
            </header>

            <main class="modal-body">
                <slot />
            </main>

            <footer class="modal-footer">
                <Button @click="$emit('close')" class="btn-cancel">Cancelar</Button>
                <Button @click="$emit('confirm')" class="btn-confirm">Confirmar</Button>
            </footer>
        </div>
    </div>
</template>

<style scoped>
    .modal-overlay
    {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.6);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 1000;
        backdrop-filter: blur(4px);
    }

    .modal-container
    {
        padding-top: 20px;
        background: var(--bg);
        width: 100%;
        max-width: 500px;
        border-radius: 15px;
        overflow: hidden;
        border: 1px solid var(--border);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
        display: flex;
        flex-direction: column;
    }

    .modal-header
    {
        padding: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid var(--border);
    }

    .modal-header h3
    {
        margin: 0;
        text-transform: uppercase;
        letter-spacing: 1px;
        font-size: 1.1em;
    }

    .close-btn
    {
        background: none;
        border: none;
        font-size: 1.5em;
        color: var(--text);
        cursor: pointer;
    }

    .modal-body
    {
        padding: 20px;
    }

    .modal-footer
    {
        padding: 20px;
        display: flex;
        gap: 15px;
        justify-content: flex-end;
        background: rgba(255, 255, 255, 0.02);
        border-top: 1px solid var(--border);
    }

    .btn-cancel
    {
        background: #95a5a6 !important;
        color: white !important;
        padding: 10px 20px !important;
    }

    .btn-confirm
    {
        padding: 10px 20px !important;
    }
</style>