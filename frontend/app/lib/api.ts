const BASE_URL = 'http://localhost:3001/api';

function getToken(): string | null {
  if (typeof window === 'undefined') return null;
  return localStorage.getItem('access_token');
}

async function request<T>(endpoint: string, init?: RequestInit): Promise<T> {
  const token = getToken();
  const res = await fetch(`${BASE_URL}${endpoint}`, {
    headers: {
      'Content-Type': 'application/json',
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    },
    ...init,
  });
  if (res.status === 401) {
    localStorage.removeItem('access_token');
    window.location.href = '/login';
    throw new Error('Non authentifié');
  }
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return res.json() as Promise<T>;
}

export const api = {
  get:    <T>(url: string)                => request<T>(url),
  post:   <T>(url: string, body: unknown) => request<T>(url, { method: 'POST',   body: JSON.stringify(body) }),
  patch:  <T>(url: string, body: unknown) => request<T>(url, { method: 'PATCH',  body: JSON.stringify(body) }),
  delete: <T>(url: string)               => request<T>(url, { method: 'DELETE' }),
};
