<script setup>
</script>

<template>
    <header class="header">
        <div class="logo">
            <span>PERALTA 99</span>
        </div>
        <nav class="nav">
            <ul>
                <li>Home</li>
                <li>Denúncias</li>
                <li>Gerenciamento</li>
            </ul>
        </nav>
    </header>
</template>

<style scoped>
    .header
    {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1.2rem 2.5rem;
        background: var(--bg);
        border-bottom: 1px solid var(--border);
        backdrop-filter: blur(10px);
    }

    .logo span
    {
        font-weight: 800;
        letter-spacing: 1px;
        color: var(--accent);
    }

    .nav ul
    {
        display: flex;
        gap: 2rem;
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .nav li
    {
        font-size: 0.9rem;
        font-weight: 500;
        cursor: pointer;
        transition: color 0.3s;
    }

    .nav li:hover
    {
        color: var(--accent);
    }
</style>