<template>
    <div class="input-group">
        <label v-if="label">
            {{ label }}
        </label>

        <div class="input-container">
            <span v-if="$slots.icon" class="input-icon">
                <slot name="icon"></slot>
            </span>

            <textarea
                v-if="multiline"
                :value="modelValue"
                :placeholder="placeholder"
                :class="{ invalid: !is_valid, 'has-icon': $slots.icon }"
                @input="handle_input"
            ></textarea>

            <input
                v-else
                type="text"
                :value="modelValue"
                :placeholder="placeholder"
                :class="{ invalid: !is_valid, 'has-icon': $slots.icon }"
                @input="handle_input"
            />
        </div>
    </div>
</template>

<script>
export default
{
    name: "InputText",
    props:
        {
            modelValue:
                {
                    type: String,
                    default: ""
                },
            label: String,
            placeholder: String,
            mask: Function,
            validator: [Function, Array],
            multiline:
                {
                    type: Boolean,
                    default: false
                }
        },
    emits:
        [
            "update:modelValue"
        ],
    data()
    {
        return {
            touched: false
        };
    },
    computed:
        {
            is_valid()
            {
                if (!this.touched)
                {
                    return true;
                }

                if (!this.validator)
                {
                    return true;
                }

                if (Array.isArray(this.validator))
                {
                    return this.validator.every(fn => fn(this.modelValue));
                }

                return this.validator(this.modelValue);
            }
        },
    methods:
        {
            handle_input(event)
            {
                this.touched = true;
                let value = event.target.value;

                if (this.mask)
                {
                    value = this.mask(value);
                    event.target.value = value;
                }

                this.$emit("update:modelValue", value);
            }
        }
};
</script>

<style scoped>
.input-group
{
    display: flex;
    flex-direction: column;
    gap: 8px;
    width: 100%;
}

label
{
    font-size: 0.7em;
    font-weight: 600;
    letter-spacing: 1.5px;
    color: var(--text);
    text-transform: uppercase;
}

.input-container
{
    position: relative;
    display: flex;
    align-items: center;
    width: 100%;
}

.input-icon
{
    position: absolute;
    left: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--yellow, #f3df13);
    pointer-events: none;
    z-index: 2;
}

input, textarea
{
    width: 100%;
    padding: 18px;
    border-radius: 8px;
    border: 1px solid var(--border);
    background: var(--bg);
    color: var(--text);
    outline: none;
    transition: border-color 0.3s;
    font-size: .9em;
    font-family: inherit;
}

input.has-icon, textarea.has-icon
{
    padding-left: 48px;
}

textarea
{
    resize: vertical;
    min-height: 100px;
}

input:focus, textarea:focus
{
    border-color: var(--accent);
}

.invalid
{
    border-color: #ff4d4d;
}
</style>