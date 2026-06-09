import re

def parse_functions(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Simple regex to find functions: "function name("
    matches = re.finditer(r'function\s+([a-zA-Z0-9_$]+)\s*\(', content)
    funcs = {}
    for m in matches:
        name = m.group(1)
        # Find brace index
        start_idx = m.end()
        funcs[name] = m.start()
    return funcs

uichanges_path = "uichanges/interviehire-3d-main/src/dashboard.js"
current_path = "frontend-final-final/src/dashboard.js"

ui_funcs = parse_functions(uichanges_path)
curr_funcs = parse_functions(current_path)

print("--- Functions in uichanges but NOT in current ---")
for f in ui_funcs:
    if f not in curr_funcs:
        print(f" - {f}")

print("\n--- Functions in current but NOT in uichanges ---")
for f in curr_funcs:
    if f not in ui_funcs:
        print(f" - {f}")

print("\n--- Common functions with size or position check ---")
# Let's see some key differences
print(f"uichanges count: {len(ui_funcs)}, current count: {len(curr_funcs)}")
