<script setup>
</script>

<template>
    <footer class="footer">
        <div class="content">
            <p>&copy; 2026 | Peralta 99 — Sistema de Denuncias</p>
            <div class="links">
                <span>Privacidade</span>
                <span>Termos</span>
            </div>
        </div>
    </footer>
</template>

<style scoped>
    .footer
    {
        margin-top: auto;
        padding: 1rem 2rem;
        border-top: 1px solid var(--border);
        background: var(--bg);
    }

    .content
    {
        display: flex;
        justify-content: space-between;
        align-items: center;
        max-width: 1126px;
        margin: 0 auto;
        font-size: 0.8rem;
        opacity: 0.7;
    }

    .links
    {
        display: flex;
        gap: 1.5rem;
    }
</style>