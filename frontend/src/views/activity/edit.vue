<template>
  <activity-editor :is-edit='true'></activity-editor>
</template>

<script>
import ActivityEditor from './components/ActivityEditor'
export default {
  name: 'createForm',
  components: { ActivityEditor }
}
</script>

