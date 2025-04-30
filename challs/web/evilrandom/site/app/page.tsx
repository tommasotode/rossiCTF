import Link from 'next/link'

export default function Home() {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-gray-100">
      <div className="bg-white p-8 rounded-lg shadow-md w-96 text-center">
        <h1 className="text-2xl font-bold mb-4 text-gray-800">Welcome</h1>
        <p className="mb-6 text-gray-600">
          Visit the{' '}
          <Link href="/admin" className="text-blue-500 hover:underline">
            Admin Dashboard
          </Link>
        </p>
        <div className="space-y-2">
          <Link
            href="/login"
            className="inline-block w-full px-4 py-2 text-white bg-blue-500 rounded-md hover:bg-blue-600 transition-colors"
          >
            Admin Login
          </Link>
        </div>
      </div>
    </div>
  )
}