function fish_prompt --description 'Write out the prompt'
    printf '%s%s%s\n%s»%s ' (set_color blue) (prompt_pwd) (set_color normal) (set_color black) (set_color normal)
end
