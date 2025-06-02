export default function AdminPage() {
  const flag = process.env.FLAG;
  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-100">
      <div className="bg-white p-8 rounded-lg shadow-md w-128">
        <h1 className="text-2xl font-bold mb-4 text-gray-800">Bentornato admin!</h1>
        <p className="text-gray-600">{flag}</p>
      </div>
    </div>
  )
}