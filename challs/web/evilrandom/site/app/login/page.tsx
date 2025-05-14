'use client'

import { useRouter, useSearchParams } from 'next/navigation'

export default function LoginPage() {
  const router = useRouter()
  const error = useSearchParams().get('error')

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()
    const formData = new FormData(e.currentTarget)
    
    try {
      const response = await fetch('/api/login', {
        method: 'POST',
        body: formData,
      })

      if (response.ok) {
        router.push('/admin')
      } else {
        router.push('/login?error=wrong')
      }
    } catch {
      router.push('/login?error=connection')
    }
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-100">
      <form 
        onSubmit={handleSubmit}
        className="bg-white p-8 rounded-lg shadow-md w-96"
      >
        <h1 className="text-2xl font-bold mb-6 text-gray-800">Admin Login</h1>
        
        {error && (
          <p className="text-red-500 mb-4">
            {error === 'wrong' ? 'Wrong password' : 'Connection error'}
          </p>
        )}

        <div className="mb-4">
          <label className="block text-gray-700 mb-2" htmlFor="password">
            Password
          </label>
          <input
            type="password"
            name="password"
            id="password"
            className="w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            required
          />
        </div>

        <button
          type="submit"
          className="w-full bg-blue-500 text-white py-2 px-4 rounded-md hover:bg-blue-600 transition-colors"
        >
          Sign In
        </button>
      </form>
    </div>
  )
}