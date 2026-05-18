<script setup>
    import { ref } from 'vue';
    import { BIconPersonCircle, BIconChevronDown } from 'bootstrap-icons-vue';

    const isDropdownOpen = ref(false);

    const toggleDropdown = () =>
    {
        isDropdownOpen.value = !isDropdownOpen.value;
    };
</script>

<template>
    <header class="header">
        <div class="header-container">
            <div class="left-section">
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
            </div>

            <div class="right-section">
                <div class="user-menu" @click="toggleDropdown">
                    <div class="user-trigger">
                        <BIconPersonCircle class="user-icon" />
                        <BIconChevronDown class="arrow-icon" />
                    </div>

                    <div v-if="isDropdownOpen" class="dropdown-container">
                        <div class="dropdown-header">
                            <span>Minha Conta</span>
                        </div>

                        <ul class="dropdown-list">
                            <li>Perfil</li>
                            <li class="logout-item">Sair</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </header>
</template>

<style scoped>
    .header
    {
        width: 100%;
        background: var(--bg);
        border-bottom: 1px solid var(--border);
        backdrop-filter: blur(10px);
        position: sticky;
        top: 0;
        z-index: 100;
        box-sizing: border-box;
    }

    .header-container
    {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin: 0 auto;
        padding: 20px 40px;
        width: 100%;
        box-sizing: border-box;
    }

    .left-section
    {
        display: flex;
        align-items: center;
        gap: 5rem;
    }

    .logo span
    {
        font-weight: 800;
        letter-spacing: 1.5px;
        color: var(--accent);
        font-size: 1.1rem;
    }

    .nav ul
    {
        display: flex;
        gap: 2.5rem;
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .nav li
    {
        font-size: 0.8rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 1.2px;
        cursor: pointer;
        transition: color 0.3s, opacity 0.3s;
        color: var(--text);
        opacity: 0.7;
    }

    .nav li:hover
    {
        color: var(--accent);
        opacity: 1;
    }

    .right-section
    {
        display: flex;
        align-items: center;
    }

    .user-menu
    {
        position: relative;
        cursor: pointer;
        user-select: none;
    }

    .user-trigger
    {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 6px 12px;
        border-radius: 20px;
        transition: background-color 0.3s;
    }

    .user-trigger:hover
    {
        background: rgba(255, 255, 255, 0.05);
    }

    .user-icon
    {
        font-size: 1.4rem;
        color: var(--text);
    }

    .arrow-icon
    {
        font-size: 0.9rem;
        color: var(--text);
        opacity: 0.7;
    }

    .dropdown-container
    {
        position: absolute;
        right: 0;
        top: calc(100% + 8px);
        background: var(--bg);
        border: 1px solid var(--border);
        border-radius: 8px;
        width: 180px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
        overflow: hidden;
        animation: fadeIn 0.2s ease;
    }

    .dropdown-header
    {
        padding: 12px 16px;
        font-size: 0.75rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
        opacity: 0.5;
        border-bottom: 1px solid var(--border);
    }

    .dropdown-list
    {
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .dropdown-list li
    {
        padding: 12px 16px;
        font-size: 0.85rem;
        color: var(--text);
        transition: background-color 0.2s;
    }

    .dropdown-list li:hover
    {
        background: rgba(255, 255, 255, 0.03);
    }

    .dropdown-list .logout-item
    {
        border-top: 1px solid var(--border);
        color: #e74c3c;
    }

    .dropdown-list .logout-item:hover
    {
        background: rgba(231, 76, 60, 0.05);
        color: #e74c3c;
    }

    @keyframes fadeIn
    {
        from
        {
            opacity: 0;
            transform: translateY(-4px);
        }
        to
        {
            opacity: 1;
            transform: translateY(0);
        }
    }
</style>