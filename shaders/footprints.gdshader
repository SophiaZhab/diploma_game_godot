shader_type canvas_item;

uniform sampler2D snow_texture; 
uniform sampler2D footprint_mask;
uniform float footprint_opacity = 1.0;

void fragment() {
    vec4 snow = texture(snow_texture, UV);
    vec4 footprints = texture(footprint_mask, UV);
    snow.rgb = mix(snow.rgb, vec3(0.6, 0.6, 0.6), footprints.r * footprint_opacity);
    COLOR = snow;
}
