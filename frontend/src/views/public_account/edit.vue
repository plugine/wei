<template>
  <account-editor :is-edit='true'></account-editor>
</template>

<script>
import AccountEditor from './components/AccountEditor'
export default {
  name: 'createForm',
  components: { AccountEditor }
}
</script>

