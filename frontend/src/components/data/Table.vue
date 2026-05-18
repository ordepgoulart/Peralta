<script setup>
    const props = defineProps(
        {
            columns: { type: Array, required: true },
            data: { type: Array, required: true }
        });

    const emit = defineEmits(['edit', 'delete']);
</script>

<template>
    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th v-for="col in columns" :key="col.key">
                    {{ col.label }}
                </th>
                <th class="actions-header">Ações</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="(item, index) in data" :key="index">
                <td v-for="col in columns" :key="col.key">
                        <span v-if="col.type === 'category'"
                              class="badge"
                              :style="{ backgroundColor: col.colors?.[item[col.key]]+'50' || 'var(--accent)', color: col.textColors?.[item[col.key]] || col.colors?.[item[col.key]] }">
                            {{ item[col.key] }}
                        </span>

                    <span v-else>
                            {{ item[col.key] }}
                        </span>
                </td>

                <td class="actions-cell">
                    <button @click="emit('edit', item)" class="btn-table btn-edit">
                        Alterar
                    </button>

                    <button @click="emit('delete', item)" class="btn-table btn-delete">
                        Remover
                    </button>
                </td>
            </tr>

            <tr v-if="data.length === 0">
                <td :colspan="columns.length + 1" class="no-data">
                    Nenhum registro encontrado.
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</template>

<style scoped>
    .table-container
    {
        width: 100%;
        overflow-x: auto;
        border-radius: 12px;
        border: 1px solid var(--border);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    }

    table
    {
        width: 100%;
        border-collapse: collapse;
        background: var(--bg);
        color: var(--text);
        text-align: left;
    }

    th, td
    {
        padding: 8px 16px;
        border-bottom: 1px solid var(--border);
        vertical-align: middle;
    }

    thead th
    {
        background: rgba(255, 255, 255, 0.02);
        text-transform: uppercase;
        font-size: 0.7em;
        font-weight: 700;
        letter-spacing: 1.5px;
        color: var(--text);
        border-bottom: 1px solid var(--border);
    }

    tbody tr:last-child td
    {
        border-bottom: none;
    }

    tbody tr
    {
        transition: background-color 0.2s ease;
    }

    tbody tr:hover
    {
        background: rgba(255, 255, 255, 0.03);
    }

    .badge
    {
        padding: 4px 10px;
        border-radius: 50px;
        font-size: 0.7em;
        font-weight: 600;
        display: inline-block;
        text-transform: uppercase;
    }

    .actions-header
    {
        width: 100px;
        text-align: center;
    }

    .actions-cell
    {
        display: flex;
        gap: 10px;
        justify-content: center;
    }

    .btn-table
    {
        border: none;
        background: transparent;
        cursor: pointer;
        padding: 12px;
        border-radius: 6px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: .9em;
        transition: all 0.2s ease;
    }

    .btn-edit
    {
        color: #3498db;
    }

    .btn-delete
    {
        color: #e74c3c;
    }

    .no-data
    {
        text-align: center;
        padding: 30px;
        opacity: 0.5;
        font-style: italic;
    }
</style>