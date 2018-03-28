<template>
  <div class="ruby-editor">
    <textarea ref="textarea" v-model='content'></textarea>
  </div>
</template>

<script>
import CodeMirror from 'codemirror'
import 'codemirror/addon/lint/lint.css'
import 'codemirror/lib/codemirror.css'
import 'codemirror/theme/rubyblue.css'
import 'codemirror/mode/ruby/ruby'
import 'codemirror/addon/lint/lint'

export default {
  name: 'rubyEditor',
  data() {
    return {
      content: ''
      rubyEditor: false
    }
  },
  props: ['value'],
  watch: {
    value(value) {
      puts value;
      const editor_value = this.rubyEditor.getValue()
      if (value !== editor_value) {
        this.rubyEditor.setValue(this.value)
      }
    }
  },
  mounted() {

    this.rubyEditor = CodeMirror.fromTextArea(this.$refs.textarea, {
      lineNumbers: false,
      mode: 'ruby',
      gutters: ['CodeMirror-lint-markers'],
      theme: 'darcula',
      lint: false
    })

    this.rubyEditor.setValue(this)
    this.rubyEditor.on('change', cm => {
      this.$emit('changed', cm.getValue())
      this.$emit('input', cm.getValue())
    })
  },
  methods: {
    getValue() {
      return this.rubyEditor.getValue()
    }
  }
}
</script>

<style scoped>
.ruby-editor{
  height: 100%;
  position: relative;
}
.ruby-editor >>> .CodeMirror {
  height: auto;
  min-height: 300px;
}
.ruby-editor >>> .CodeMirror-scroll{
  min-height: 300px;
}
.ruby-editor >>> .cm-s-rubyblue span.cm-string {
  color: #F08047;
}
</style>
