shader_type canvas_item;

uniform sampler2D snow_texture : hint_default_white, filter_linear_mipmap;
uniform sampler2D trail_mask : hint_default_black, filter_linear_mipmap;
uniform float trail_intensity : hint_range(0.0, 1.0) = 0.8;
uniform vec4 snow_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 trail_color : source_color = vec4(0.7, 0.7, 0.8, 1.0);

// Параметри блискіток
uniform float glitter_density : hint_range(10.0, 100.0) = 30.0;
uniform float glitter_size : hint_range(0.01, 0.1) = 0.03;
uniform float glitter_brightness : hint_range(0.5, 3.0) = 2.0;
uniform float glitter_speed : hint_range(0.5, 5.0) = 2.0;
uniform vec4 glitter_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec2 glitter_center = vec2(0.5, 0.5);
uniform float glitter_radius : hint_range(0.05, 0.5) = 0.2;

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

void fragment() {
    vec4 snow_tex = texture(snow_texture, UV);
    vec4 trail_tex = texture(trail_mask, UV);
    
    // Базовий колір снігу зі слідами
    vec4 base_color = mix(snow_tex * snow_color, trail_color, trail_tex.r * trail_intensity);
    
    // Обчислюємо відстань від блискіток до центру плями
    float dist_to_center = distance(UV, glitter_center);
    
    // Розрахунок блискіток тільки в області
    float inside_glitter_area = step(dist_to_center, glitter_radius);
    
    vec2 local_uv = (UV - glitter_center) / glitter_radius + 0.5;
    vec2 grid_uv = local_uv * glitter_density;
    vec2 grid_id = floor(grid_uv);
    vec2 grid_fract = fract(grid_uv);
    
    float random_seed = hash(grid_id);
    
    // Позиція блискітки в клітинці
    vec2 glitter_pos = vec2(
        hash(grid_id + vec2(0.1, 0.0)),
        hash(grid_id + vec2(0.0, 0.1))
    );
    
    // Відстань до блискітки
    vec2 to_glitter = grid_fract - glitter_pos;
    float dist_to_glitter = length(to_glitter);
    
    // Кругла блискітка
    float glitter_mask = 1.0 - smoothstep(glitter_size * 0.5, glitter_size, dist_to_glitter);
    
    // Кожна блискітка пульсує з власною швидкістю
    float time_offset = random_seed * 6.28;
    float twinkle = sin(TIME * glitter_speed + time_offset) * 0.5 + 0.5;
    twinkle = smoothstep(0.2, 0.8, twinkle); // Робимо пульсацію більш контрастною
    
    // Не всі блискітки активні одночасно
    float glitter_chance = step(0.6, random_seed); // 40% шанс на появу
    
    glitter_mask *= twinkle * glitter_chance * inside_glitter_area;
    
    // Додаємо блискітки
    vec4 glitter = glitter_color * glitter_mask * glitter_brightness;
    vec4 final_color = base_color + glitter;
    
    COLOR = final_color;
}