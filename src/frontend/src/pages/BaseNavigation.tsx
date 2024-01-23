import { Navigate } from "react-router-dom"
import { useAuth } from "../contexts/AuthContext/contexts"

export default function BaseNavigation() {
    const { isLoggedIn } = useAuth()
    const path = isLoggedIn ? "/home" : "/login"

    return <Navigate to={path} />
}
