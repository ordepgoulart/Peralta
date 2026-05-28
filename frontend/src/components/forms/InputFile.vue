<template>
    <div class="upload-container">
        <label v-if="label" class="field-label">
            {{ label }}
        </label>

        <label class="drop-zone">
            <span>
                Selecionar Imagens
            </span>
            <input type="file" multiple accept="image/*" @change="handle_upload" />
        </label>

        <div class="preview-grid" v-if="previews.length > 0">
            <div v-for="(img, index) in previews" :key="index" class="thumb">
                <img :src="img" />
                <button type="button" @click="remove_image(index)" class="remove-btn">
                    &times;
                </button>
            </div>
        </div>
    </div>
</template>

<script>
export default
{
    name: "InputFile",
    props:
        {
            modelValue:
                {
                    type: Array,
                    default: () => []
                },
            label:
                {
                    type: String,
                    default: ""
                }
        },
    emits:
        [
            "update:modelValue"
        ],
    data()
    {
        return {
            previews: []
        };
    },
    watch:
        {
            modelValue(newVal)
            {
                if (newVal.length === 0 && this.previews.length > 0)
                {
                    this.previews = [];
                }
            }
        },
    methods:
        {
            handle_upload(event)
            {
                const files = Array.from(event.target.files);

                files.forEach(file =>
                {
                    const reader = new FileReader();

                    reader.onload = (e) =>
                    {
                        this.previews.push(e.target.result);
                        this.$emit("update:modelValue", this.previews);
                    };

                    reader.readAsDataURL(file);
                });
            },
            remove_image(index)
            {
                this.previews.splice(index, 1);
                this.$emit("update:modelValue", this.previews);
            }
        }
};
</script>

<style scoped>
.upload-container
{
    width: 100%;
}

.field-label
{
    font-size: 0.7em;
    font-weight: 600;
    letter-spacing: 1.5px;
    color: var(--text);
    text-transform: uppercase;
    display: block;
    margin-bottom: 8px;
}

.drop-zone
{
    font-size: .85em;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100px;
    border: 1px dashed var(--border);
    border-radius: 12px;
    cursor: pointer;
    transition: .25s ease;
    background: var(--background-secondary);
    color: var(--text);
}

.drop-zone:hover
{
    border-color: var(--accent);
    background: rgba(243, 223, 19, 0.08);
    color: var(--accent);
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
    background: rgba(0, 0, 0, 0.85);
    color: white;
    border: none;
    border-radius: 50%;
    width: 24px;
    height: 24px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background 0.2s, transform 0.2s;
}

.remove-btn:hover
{
    background: #ff4d57;
    transform: scale(1.1);
}
</style>