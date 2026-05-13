<script setup>
    import { ref } from 'vue';

    const previews = ref([]);


    // ---> Mr. Sá ↓

    const handle_upload = (event) =>
    {
        // [?] Pega todos os arquivos selecionados do input
        const files = Array.from(event.target.files);
        // [?] Percorre cada arquivo selecionado
        files.forEach(file =>
        {
            // [?] Cria um leitor de arquivos (do navegador)
            const reader = new FileReader();

            // [?] Quando o arquivo terminar de carregar
            reader.onload = (e) =>
            {
                // [?] Adiciona a imagem no array de previews
                previews.value.push(e.target.result);
            };

            // [?] Lê o arquivo e converte para uma URL base64
            reader.readAsDataURL(file);
        });
    };

    const remove_image = (index) =>
    {
        previews.value.splice(index, 1);
    };
</script>

<template>
    <div class="upload-container">
        <label class="drop-zone">
            <span>Selecionar Imagens</span>
            <input type="file" multiple accept="image/*" @change="handle_upload" />
        </label>

        <div class="preview-grid" v-if="previews.length > 0">
            <div v-for="(img, index) in previews" :key="index" class="thumb">
                <img :src="img" />
                <button @click="remove_image(index)" class="remove-btn">&times;</button>
            </div>
        </div>
    </div>
</template>

<style scoped>
    .upload-container
    {
        width: 100%;
    }

    .drop-zone
    {
        font-size: .85em;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 100px;
        border: 1px solid var(--border);
        border-radius: 12px;
        cursor: pointer;
        transition: .25s ease;
        background: var(--background-secondary);
    }

    .drop-zone:hover
    {
        border-color: var(--accent);
        background: color-mix(in srgb, var(--accent) 8%, transparent);
    }

    .drop-zone input
    {
        display: none;
    }

    .preview-grid
    {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
        gap: 15px;
        margin-top: 20px;
    }

    .thumb
    {
        position: relative;
        aspect-ratio: 1;
        border-radius: 8px;
        overflow: hidden;
        border: 1px solid var(--border);
    }

    .thumb img
    {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .remove-btn
    {
        position: absolute;
        top: 5px;
        right: 5px;
        background: rgba(0, 0, 0, 0.7);
        color: white;
        border: none;
        border-radius: 50%;
        width: 20px;
        height: 20px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
    }
</style>