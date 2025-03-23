shader_type canvas_item;

uniform vec4 blink_color : source_color;
uniform float blink_intensity = 0.0;

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
    vec4 final_color = mix(original_color, blink_color, blink_intensity * original_color.a);
    COLOR = final_color;
}