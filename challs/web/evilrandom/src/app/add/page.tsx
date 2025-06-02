import Link from "next/link";

export default function AdminPage() {
    return (
        <div className="min-h-screen flex flex-col items-center justify-center bg-gray-100 space-y-4">
            <h1 className="text-2xl font-bold text-gray-800">Work in progress</h1>
            <h2 className="text-2xl font-bold text-gray-800">Fatti bastare quelle che ci sono 😤</h2>
            <br></br>
            <Link
                href="https://www.youtube.com/watch?v=dQw4w9WgXcQ"
                className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
            >
                Flag gratis
            </Link>
            <Link
                href="/"
                className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
            >
                Torna indietro
            </Link>
        </div>

    )
}