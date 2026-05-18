<script setup>
    import { ref, computed } from 'vue';
    import InputText from '../forms/InputText.vue';
    import Table from "./Table.vue";
    import GenericModal from "../ui/Modal.vue";
    import RowDivision from "../layout/RowDivision.vue";
    import { BIconPlus } from 'bootstrap-icons-vue';

    const props = defineProps(
        {
            title: String,
            columns: Array,
            data: Array,
            searchPlaceholder: { type: String, default: 'Buscar...' },
            filterKey: { type: String, default: 'name' },
            maxWidth: { type: String, default: '1000px' }
        });

    const emit = defineEmits(['edit', 'delete', 'save']);

    const searchQuery = ref('');
    const isModalOpen = ref(false);
    const modalType = ref('create');
    const selectedItem = ref({});

    const filteredData = computed(() =>
    {
        if (!searchQuery.value)
            return props.data;

        const query = searchQuery.value.toLowerCase();
        return props.data.filter(item => String(item[props.filterKey]).toLowerCase().includes(query));
    });

    const openModal = (type, item = {}) =>
    {
        modalType.value = type;
        selectedItem.value = { ...item };
        isModalOpen.value = true;
    };

    const handleConfirm = () =>
    {
        if (modalType.value === 'delete')
            emit('delete', selectedItem.value);
        else
            emit('save', selectedItem.value);

        isModalOpen.value = false;
    };
</script>

<template>
    <div class="manager-layout" :style="{ maxWidth: maxWidth + 'px' }">
        <header class="manager-header">
            <h2>{{ title }}</h2>

            <div class="actions-row">
                <div class="search-bar">
                    <InputText v-model="searchQuery" :placeholder="searchPlaceholder" />
                </div>
                <button class="add-btn" @click="openModal('create')"><BIconPlus /></button>
            </div>
        </header>

        <Table
            :columns="columns"
            :data="filteredData"
            @edit="(item) => openModal('edit', item)"
            @delete="(item) => openModal('delete', item)"
        />

        <GenericModal
            :show="isModalOpen"
            :title="modalType === 'delete' ? 'Confirmar Exclusão' : (modalType === 'edit' ? 'Editar Registro' : 'Novo Registro')"
            @close="isModalOpen = false"
            @confirm="handleConfirm"
        >
            <div v-if="modalType === 'delete'" class="alert-content">
                <p>Deseja realmente remover este registro?</p>
                <strong>{{ selectedItem[filterKey] }}</strong>
            </div>

            <div v-else class="form-content">
                <RowDivision v-for="col in columns" :key="col.key" cols="1">
                    <InputText
                        v-if="col.key !== 'id'"
                        v-model="selectedItem[col.key]"
                        :label="col.label"
                        :placeholder="'Digite ' + col.label"
                    />
                </RowDivision>
            </div>
        </GenericModal>
    </div>
</template>

<style scoped>
    .manager-layout
    {
        width: 100%;
        display: flex;
        flex-direction: column;
        gap: 24px;
        margin: 0 auto;
    }

    .manager-header
    {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .actions-row
    {
        display: flex;
        gap: 15px;
        align-items: center;
    }

    .search-bar
    {
        flex: 1;
    }

    .add-btn
    {
        background: var(--accent);
        border: none;
        width: 50px;
        height: 50px;
        border-radius: 5px;
        font-size: 2em;
        color: #000;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: transform 0.2s;
    }

    .add-btn:hover
    {
        transform: scale(1.05);
        opacity: 0.9;
    }

    h2
    {
        margin: 0;
        color: var(--text);
        text-transform: uppercase;
        letter-spacing: 2px;
        font-weight: 700;
    }

    .alert-content
    {
        text-align: center;
        padding: 10px;
    }

    .alert-content p
    {
        margin-bottom: 10px;
    }

    .form-content
    {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }
</style>