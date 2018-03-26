export function getAuthentication() {
  return localStorage.getItem('authentication')
}

export function setAuthentication(authentication) {
  if (authentication) {
    localStorage.setItem('authentication', authentication)
  }
  return true
}

export function removeAuthentication() {
  return localStorage.removeItem('authentication')
}
