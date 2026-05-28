<template>
    <div class="row-division" :style="{ '--grid-cols': cols }">
        <slot />
    </div>
</template>

<script>
export default
{
    name: "RowDivision",
    props:
        {
            cols:
                {
                    type: [Number, String],
                    default: 1
                }
        }
};
</script>

<style scoped>
.row-division
{
    display: grid;
    grid-template-columns: repeat(var(--grid-cols), 1fr);
    gap: 20px;
    width: 100%;
    margin-bottom: 20px;
}

@media (max-width: 768px)
{
    .row-division
    {
        grid-template-columns: 1fr !important;
    }
}
</style>