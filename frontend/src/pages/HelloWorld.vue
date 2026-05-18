<script setup>
    import { ref } from "vue";
    import Manager from "../components/data/Manager.vue";
    import Header from "../components/layout/Header.vue";
    import Footer from "../components/layout/Footer.vue";

    const myColumns = [
        { key: 'id', label: 'ID' },
        { key: 'name', label: 'Nome' },
        { key: 'email', label: 'E-mail' },
        {
            key: 'role',
            label: 'Cargo',
            type: 'category',
            colors:
                {
                    'Admin': '#9b59b6',
                    'Moderador': '#e67e22',
                    'Usuário': '#34495e'
                }
        }
    ];

    const myData = ref([
        { id: 1, name: 'Mr. Sá', email: 'sa@email.com', role: 'Admin' },
        { id: 2, name: 'Mr. Pooh', email: 'pooh@email.com', role: 'Usuário' }
    ]);

    const onSave = (item) =>
    {
        if (item.id)
        {
            const index = myData.value.findIndex(i => i.id === item.id);
            myData.value[index] = item;
        }
        else
        {
            item.id = myData.value.length + 1;
            myData.value.push(item);
        }
    };

    const onDelete = (item) =>
    {
        myData.value = myData.value.filter(i => i.id !== item.id);
    };
</script>

<template>
    <Header />

    <main id="center">
        <Manager
            title="Gestão de Usuários"
            :columns="myColumns"
            :data="myData"
            filterKey="name"
            @save="onSave"
            @delete="onDelete"
            maxWidth="1400"
        />
    </main>

    <Footer />
</template>

<style scoped>
    #center
    {
        padding: 60px;
    }
</style>